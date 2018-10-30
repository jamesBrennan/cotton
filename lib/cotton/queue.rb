# frozen_string_literal: true

module Cotton
  # Queue namespace
  module Queue
    autoload :Bunny, 'cotton/queue/bunny'
    autoload :Memory, 'cotton/queue/memory'
    autoload :Supervisor, 'cotton/queue/supervisor'
  end
end
