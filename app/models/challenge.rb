class Challenge < ActiveRecord::Base

  # === List of columns ===
  #   id           : integer 
  #   name         : string 
  #   description  : string 
  #   status       : boolean 
  #   candidate_id : integer 
  #   officer_id   : integer 
  #   created_at   : datetime 
  #   updated_at   : datetime 
  # =======================

  belongs_to :candidate
  belongs_to :officer, :class_name => "Person", :foreign_key => "officer_id"

  #CHALLENGE_PENDING = null
  #CHALLENGE_COMPLETED = true
  #CHALLENGE_REJECTED = false

  def get_status_string
    if status
      return "Confirmed"
    else
      if status == nil
        return "Pending"
      else
        return "Rejected"
      end
    end
  end


end