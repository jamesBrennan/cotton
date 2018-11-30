# frozen_string_literal: true

module CottonTail
  module Middleware
    # Router Middleware
    describe Router do
      subject(:router) { described_class.new(app, handlers: route_handlers) }

      let(:env) { Hash[] }
      let(:request) { CottonTail::Request.new(delivery_info, {}, payload) }
      let(:response) { CottonTail::Response.new }

      let(:delivery_info) { { routing_key: routing_key } }
      let(:message) { [env, request, response] }

      let(:app) { double('middleware app') }

      describe '.call' do
        let(:payload) { 'payload' }

        context 'when a route is defined' do
          let(:routing_key) { 'my.test.route' }
          let(:handler) { double('handler') }
          let(:route_handlers) { Hash[routing_key, handler] }

          it 'calls the handler' do
            expect(handler).to receive(:call).with(message) { 'return val' }
            expect(app).to(
              receive(:call).with([env, request, Response.new('return val')])
            )

            router.call(message)
          end
        end

        context 'when route is not defined' do
          let(:routing_key) { 'some.unknown.route' }
          let(:route_handlers) { Hash[] }

          it 'raises an error' do
            expect { router.call(message) }.to raise_error(UndefinedRouteError)
          end
        end
      end
    end
  end
end
