describe V1::BugsController do
  describe 'routing' do
    it 'routes to #show' do
      expect(get('/bugs/1')).
        to route_to('v1/bugs#show', number: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post('/bugs')).to route_to('v1/bugs#create', format: :json)
    end

    it 'routes to #count' do
      expect(get('/bugs/count')).
        to route_to('v1/bugs#count', format: :json)
    end
  end
end
