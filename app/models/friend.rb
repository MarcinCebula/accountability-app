class Friend
  include Mongoid::Document

  belongs_to :user

  field :name,     type: String
  field :phone,    type: String

  before_validation do |rec|
    rec.phone = rec.phone.parameterize.gsub('-', '')
    if rec.phone.length == 11
      rec.phone = rec.phone = rec.phone[1..-1]
    end
  end

  after_save do |friend|
    @twillio = Twilio::REST::Client.new
    @twillio.messages.create(
                             from: '+13472692547',
                             to: "+1#{friend.phone}",
                             body: "#{friend.user.name} added you to #{APP_NAME} to be notified of his/her progress"
                             )

  end
end
