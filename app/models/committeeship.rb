class Committeeship < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   committee  : string 
  #   semester   : string 
  #   title      : string 
  #   created_at : datetime 
  #   updated_at : datetime 
  #   person_id  : integer 
  # =======================

  @Committees = %w(pres vp rsec treas csec deprel act alumrel bridge compserv indrel serv studrel tutoring pub examfiles ejc)	#This generates a constant which is an array of possible committees.
  Semester = /^\d{4}[0-4]$/	#A regex which validates the semester
  Positions = %w(officer cmember candidate)	#A list of possible positions
  validates_inclusion_of :committee, :in => @Committees, :message => "Committee not recognized."
  validates_format_of :semester, :with => Semester, :message => "Not a valid semester."
  validates_inclusion_of :title, :in => Positions, :message => "Not a valid title." 
  validates_uniqueness_of :committee, :scope => [:person_id, :semester]
  
  belongs_to :person

  # We have this argumentless lambda because we don't want to evaluate 
  # Property.semester until we call the scope, not when we define it
  scope :current, lambda{ { :conditions => { :semester => Property.semester } } }
  scope :committee, lambda{|x| { :conditions => { :committee => x } } }
  scope :officers, :conditions => { :title => "officer" }
  scope :cmembers, :conditions => { :title => "cmember" }
  scope :candidates, :conditions => { :title => "candidate" }

  class << self
    attr_reader :Committees, :Positions
  end

  SEMESTER_MAP = { 1 => "Spring", 2 => "Summer", 3 => "Fall" }

  def nice_semester
    "#{SEMESTER_MAP[semester[-1..-1].to_i]} #{semester[0..3]}"
  end

  def nice_position
    execs = %w[pres vp rsec treas csec]
    if execs.include? committee
      nice_committee
    else
      "#{nice_committee} #{nice_title}"
    end
  end

  def nice_title
    nice_titles = { 
      "officer" => "Officer", 
      "cmember" => "Committee Member", 
      "candidate" => "Candidate" 
    }
    nice_titles[title]
  end

  def nice_committee
    nice_committees = { 
      "pres"     => "President", 
      "vp"       => "Vice President", 
      "rsec"     => "Recording Secretary",
      "csec"     => "Corresponding Secretary",
      "treas"    => "Treasurer",
      "deprel"   => "Department Relations",
      "act"      => "Activities",
      "alumrel"  => "Alumni Relations",
      "bridge"   => "Bridge",
      "compserv" => "Computing Services",
      "indrel"   => "Industrial Relations",
      "serv"     => "Service",
      "studrel"  => "Student Relations",
      "tutoring" => "Tutoring",
      "pub"      => "Publicity",
      "examfiles"=> "Exam Files",
    }
    nice_committees[committee]
  end
end
