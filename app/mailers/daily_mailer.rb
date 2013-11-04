class DailyMailer < ActionMailer::Base
  default :from => "file_uploader@site.com"
  
  def daily_notification(items)
    @items = items
    mail(:to => CONFIG[:admin_email], :subject => "daily file upload")
  end
end
