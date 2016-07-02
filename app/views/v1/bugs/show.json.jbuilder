json.extract! @bug, :number, :status, :priority
json.extract! @bug.state, :memory, :os, :storage, :device
