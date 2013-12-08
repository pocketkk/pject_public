class Sms

  if Rails.env.test? || Rails.env.development?
    @@sent_smses = []
    cattr_accessor :sent_smses
  end

  def send(to, message)
    if Rails.env == "production"
      @client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
      @client.account.sms.messages.create(from: TWILIO_CONFIG['from'], to: to, body: message)
    else
      @@sent_smses << { to: to, from: TWILIO_CONFIG['from'], body: message }
    end
  end

  def valid?
    true
  end
  
end

