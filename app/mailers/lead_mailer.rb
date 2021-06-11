class LeadMailer < ApplicationMailer

  def delivery_lead_email(project, user)
    @project = project
    @user = user
    mail(:to => @project.email, :subject => '¡Cliente potencial!')
  end
end
