class GenderGuesserService
  def self.guess(name)
    name = Gendered::Name.new(name)
    name.guess!
    name.gender
  end
end
