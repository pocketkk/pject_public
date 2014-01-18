class SmsArgumentError < ArgumentError; end

class Sms

  if Rails.env.test? || Rails.env.development?
    @@sent_smses = []
    cattr_accessor :sent_smses
  end

  def initialize
    @client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
  end

  def handle_options(options={})
    @phone_number = options.fetch(:phone_number) { raise SmsArgumentError }
    @message = options.fetch(:message) { "" }
  end

  def send_sms(options={})
    handle_options(options)
    if Rails.env == "test" || Rails.env =="development"
      @@sent_smses << { to: @phone_number, from: TWILIO_CONFIG['from'], body: @message }
    else
      @client.account.sms.messages.create(from: TWILIO_CONFIG['from'], to: @phone_number, body: @message)
    end
  end

  def valid?
    true
  end
  
end

