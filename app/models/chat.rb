class Chat < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  has_many :messages

  validates :sender_id, :receiver_id, presence: true
  validate :sender_and_receiver_must_be_different

  scope :for_user, ->(user) {
    where("sender_id = ? OR receiver_id = ?", user.id, user.id)
  }

  def other_participant(current_user)
    current_user.id == sender_id ? receiver : sender
  end

  private

  def sender_and_receiver_must_be_different
    if sender_id == receiver_id
      errors.add(:receiver_id, "no puede ser la misma persona que el remitente")
    end
  end
end
