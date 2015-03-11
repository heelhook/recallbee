class ToySearchService
  def self.upc(upc)
    client = semantics3
    client.products_field 'upc', upc
    results = client.get_products

    results['results'].collect do |item|
      RecursiveOpenStruct.new(item)
    end
  end

  def self.search(key, index='All')
    client = vacuum
    response = client.item_search(
      query: {
        'Keywords' => key,
        'SearchIndex' => index,
        'ResponseGroup' => 'ItemAttributes,Images',
      },
    ).to_h

    [response['ItemSearchResponse']['Items']['Item']].flatten.compact.collect do |item|
      toy_from_vacuum(item)
    end
  end

  private

  def self.toy_from_vacuum(item)
    toy = Toy.find_or_initialize_by(upc: item['ItemAttributes']['UPC'])
    toy.update_attributes(
      provider: 'amazon',
      upc: item['ItemAttributes']['UPC'],
      name: (item['ItemAttributes']['Title'] rescue nil),
      image: (item['MediumImage']['URL'] rescue nil),
      maker: (item['ItemAttributes']['Manufacturer'] rescue nil),
      minimum_age_months: (item['ItemAttributes']['ManufacturerMinimumAge']['__content__'].to_i rescue nil),
      maximum_age_months: (item['ItemAttributes']['ManufacturerMaximumAge']['__content__'].to_i rescue nil),
    )
    toy
  end

  def self.semantics3
    Semantics3::Products.new(Rails.application.secrets.semantics3_api_key, Rails.application.secrets.semantics3_api_secret)
  end

  def self.vacuum
    request = Vacuum.new
    request.configure(
      aws_access_key_id: Rails.application.secrets.amazon_api_key,
      aws_secret_access_key: Rails.application.secrets.amazon_api_secret,
      associate_tag: Rails.application.secrets.amazon_tag,
    )
  end
end
