require "rails_helper"

RSpec.describe "Risk Profile Calculator", :type => :request do
  it "" do
    post "/calculator", params: {
        age: 35,
        dependents: 2,
        house: {"ownership_status": "owned"},
        income: 0,
        marital_status: "married",
        risk_questions: [0, 1, 0],
        vehicle: {"year": 2018}
    }

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("")
  end
end