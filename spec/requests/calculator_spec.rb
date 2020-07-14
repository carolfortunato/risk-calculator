require "rails_helper"

RSpec.describe "Risk Profile Calculator", :type => :request do
  it "receives user data and returns insurance profile" do
    post "/calculator", params: {
        age: 35,
        dependents: 2,
        income: 100,
        marital_status: "married",
        risk_questions: [0, 1, 0],
        house: {"ownership_status": "owned"},
        vehicle: {"year": 2018}
    }

    json = {
        auto: 'regular',
        disability: 'economic',
        home: 'regular',
        life: 'regular'
    }.to_json

    expect(response).to have_http_status(:ok)
    expect(response.body).to eq(json)
  end

  it "returns ineligle for auto and house" do
    post "/calculator", params: {
        age: 35,
        dependents: 2,
        income: 100,
        marital_status: "married",
        risk_questions: [0, 1, 0],
        house: nil,
        vehicle: nil
    }

    json = {
        auto: 'ineligible',
        disability: 'economic',
        home: 'ineligible',
        life: 'regular'
    }.to_json

    expect(response).to have_http_status(:ok)
    expect(response.body).to eq(json)
  end

  it "returns ineligle for all insurances" do
    post "/calculator", params: {
        age: 61,
        dependents: 2,
        income: 0,
        marital_status: "married",
        risk_questions: [0, 1, 0],
        house: nil,
        vehicle: nil
    }

    json = {
        auto: 'ineligible',
        disability: 'ineligible',
        home: 'ineligible',
        life: 'ineligible'
    }.to_json

    expect(response).to have_http_status(:ok)
    expect(response.body).to eq(json)
  end
end