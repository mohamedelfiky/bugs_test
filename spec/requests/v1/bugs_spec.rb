require 'rails_helper'
require 'rack/test'

describe V1::BugsController do
  let(:bug) do
    b = build(:bug)
    b.increment_bugs_count
    b.save!
    b
  end

  let(:json) { JSON.parse(response.body) }
  let(:application_token) { { 'x-application-token' => bug.application_token } }

  describe 'GET #show' do
    context 'with valid params' do
      before { get "/bugs/#{ bug.number }", {}, application_token }

      it 'returns http success' do
        expect(response).to be_success
      end

      it 'renders correct template' do
        is_expected.to render_template('v1/bugs/show')
      end

      it 'returns the correct bug data' do
        expect(Bug.last).to eq(bug)
      end
    end

    context 'with invalid params' do
      before { get '/bugs/1000', {}, application_token }

      it 'returns http not_found 404' do
        expect(response).to be_not_found
      end

      it 'returns the error' do
        expect(json['errors']).to be_present
      end
    end
  end

  describe 'GET #count' do
    before { get '/bugs/count', {}, application_token }

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'returns the correct bug data' do
      bugs_count = Bug.where(application_token: bug.application_token).count
      expect(bugs_count).to eq(json['count'].to_i)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:attributes) { { bug: attributes_for(:bug).merge(state_attributes: attributes_for(:state)) } }
      before do
        post '/bugs', attributes, application_token
      end

      it 'returns http `created`' do
        expect(response).to be_created
      end

      it 'return bug number' do
        expect(json['number']).to be_present
      end
    end

    context 'with invalid params' do
      before { post '/bugs', { bug: { application_token: '' } }, application_token }

      it 'returns unprocessable entity' do
        expect(response).to be_unprocessable
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end

    context 'without bug object' do
      before { post '/bugs', { application_token: '' }, application_token }

      it 'returns unprocessable entity' do
        expect(response).to be_bad_request
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end

    describe 'raise error when post with invalid params' do
      before { post '/bugs', { bug: attributes_for(:bug) }, application_token }

      it 'returns http `error`' do
        expect(response).to be_error
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end
  end
end
