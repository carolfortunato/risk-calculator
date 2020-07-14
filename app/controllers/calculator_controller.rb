class CalculatorController < ApplicationController
    # TO DO - include validation here with dry-validation gem

    def create
        @params = params.to_unsafe_h

        scores = {
            auto: final_score(auto_score),
            disability: final_score(disability_score),
            home: final_score(home_score),
            life: final_score(life_score),
        }

        render json: scores, status: :ok
    end

    private

    def final_score(score)
        return 'ineligible' if (score == false) || score == nil
        return 'economic' if score <= 0
	    return 'regular' if (score == 1) || (score == 2)
        return 'responsible' if score >= 3

    end

    def base_score
        params["risk_questions"].map(&:to_i).sum
    end

    def age_risk
        age = @params['age'].to_i
        -2 if age < 30
        -1 if age >= 30 && age <=40
        0
    end

    def income_risk
        -1 if @params['income'].to_i > 200000
        0
    end

    def dependents_risk
        1 if @params['dependents'].to_i > 0
        0
    end

    def mortgaged_house
        1 if @params['house']['ownership_status'] == 'mortgaged'
        0  
    end

    def life_score
        return false if @params['age'].to_i > 60
        score = base_score + age_risk + income_risk + dependents_risk 
        score + 1 if @params['marital_status'] == 'married' 
    end

    def disability_score
        return false if @params['income'].to_i == 0
        score = base_score + age_risk + income_risk + dependents_risk + mortgaged_house 
        score - 1 if @params['marital_status'] == 'married'
    end

    def home_score
        return false if @params['house'] == nil
        score = base_score + age_risk + income_risk + mortgaged_house
    end

    def auto_score
        return false if @params['vehicle'] == nil
        score = base_score + age_risk + income_risk
        score + 1 if @params['vehicle']['year'].to_i > Date.today.year-5 #if car year in the last 5 years
    end

end
