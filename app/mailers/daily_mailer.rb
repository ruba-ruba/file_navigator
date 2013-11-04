class DailyMailer < ActionMailer::Base
  default :from => "file_uploader@site.com"
  
  def daily_notification(items)
    @items = items
    mail(:to =>  "gunit1991@ukr.net", :subject => "daily file upload")
  end
end
