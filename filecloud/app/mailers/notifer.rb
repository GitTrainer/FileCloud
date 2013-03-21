class Notifier < ActionMailer::Base
   default from: "bui.trung.kien@framgia.com"

  def user_received(user)
    @user = user
    mail :to => user.email, :subject => 'Pragmatic Store Order Confirmation'
  end

  def order_shipped(user)
    @user = user
    mail :to => user.email, :subject => 'Pragmatic Store Order Shipped'
  end
end
