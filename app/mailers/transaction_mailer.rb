class TransactionMailer < MandrillMailer::TemplateMailer
  default from: 'safekids@recallbee.com', from_name: 'RecallBee', reply_to: 'safekids@recallbee.com'
 
  def alert(user, child)
    @subject = "Careful! One of #{child.name}'s toys has raised an alert!"

    mandrill_mail(
      template: 'alert',
      subject: @subject,
      to: {
        email: user.email,
        name: "#{user.first_name} #{user.last_name}",
      },
      vars: {
        'NAME' => user.first_name,
        'CHILD_NAME' => child.name,
        'URL' => "https://www.recallbee.com/children/#{child.slug}/alerts",
        'CURRENT_YEAR' => Date.today.year,
        'SUBJECT' => @subject,
      },
      important: true,
      inline_css: true,
      async: true,
    )
  end
end
