require "rails_helper"

RSpec.describe "Risk Profile Calculator", :type => :request do
  it "receives user data and returns insurance profile" do
    post "/calculator", params: {
        age: 35,
        dependents: 2,
        house: {"ownership_status": "owned"},
        income: 0,
        marital_status: "married",
        risk_questions: [0, 1, 0],
        vehicle: {"year": 2018}
    }

    json = {
        auto: 'regular',
        disability: 'ineligible',
        home: 'regular',
        life: 'regular'
    }.to_json

    expect(response).to have_http_status(:ok)
    expect(response.body).to eq(json)
  end
end