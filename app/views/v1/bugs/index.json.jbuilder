json.array! @bugs do |bug|
  json.extract! bug, :number, :status, :priority, :comment
  json.extract! bug.state, :memory, :os, :storage, :device
end
