class Task < ApplicationRecord
  validates :task_name, :detail, presence: true
  enum priority: { 高: "a", 中: "b", 低: "c" }
end
