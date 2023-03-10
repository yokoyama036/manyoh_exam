class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings, source: :label 
  accepts_nested_attributes_for :labels, allow_destroy: true, reject_if: :all_blank
  validates :task_name, :detail, presence: true
  enum priority: { 高: "a", 中: "b", 低: "c" }
  scope :search_task_name, -> (task_name){where('task_name LIKE ?', "%#{task_name}%")}
  scope :search_status, -> (status){where(status: status)}
  scope :search_task_name_status, -> (task_name, status){where('task_name LIKE ?',"%#{task_name}%").where(status: status)}
  # scope :search_label, -> (label_search) { where(label_name: label_search) }

end
