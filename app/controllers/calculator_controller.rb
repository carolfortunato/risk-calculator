class CalculatorController < ApplicationController
    # TO DO - include validation here with dry-validation gem

    def create
        render status: :ok
#       render json {
#    		auto: final_score(auto_score)
#	    	disability: final_score(disability_score)
#    		home: final_score(home_score)
#	    	life: final_score(life_score)
#	    }, status: :ok
    end

    private

    def final_score(score)
        'economic' if score <= 0
	    'regular' if score == (1 or 2)
	    'responsible' if score >= 3
    end

    def base_score
        # sum elements in array of risk_question
    end

    def life_score
        # 'ineligible' if age > 60
        # base_score + age_risk + income_risk + dependents_risk
        # + 1 point if user is married
    end

    def disability_score
        # 'ineligible' if user does not have income
        # base_score + age_risk + income_risk + dependents_risk + morgaged_house
        # - 1 point if user is married
    end

    def home_score
        # 'ineligible' if user does not have a house
        # base_score + age_risk + income_risk + morgaged_house
    end

    def auto_score
        # 'ineligible' if user does not have a car
        # base_score + age_risk + income_risk
        # + 1 point if car year in the last 5 years
    end

    def age_risk
        # - 2 points if user is under 30
        # - 1 point if user age is between 30 and 40
    end

    def income_risk
        # - 1 risk point if user income is above 200k
        
    end

    def dependents_risk
        # + 1 point if user has dependents
    end

    def morgaged_house
        # + 1 point if house == mortgaged    
    end

end
