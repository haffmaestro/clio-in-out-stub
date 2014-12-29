class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  scope :without_user, lambda {|user| where("id <> :id", :id => user.id) }
  belongs_to :team

  STATUSES = {:in => 0, :out => 1}.freeze

  validates :status, :inclusion => {:in => STATUSES.keys}

  def current_sign_in_ip=(ip)
    super(User.string_ip_to_integer(ip))
    save
  end

  def last_sign_in_ip=(ip)
    super(User.string_ip_to_integer(ip))
    save
  end

  def self.string_ip_to_integer(ip)
    #If the ip is already in integer form then just send it along
    if ip.class == "String".classify.constantize
      ip_array = ip.split('.').map(&:to_i)
      integer_ip = 0
      exponent = 3
      ip_array.each do |octet|
        integer_ip += octet*256**exponent
        exponent -= 1
      end
      integer_ip
    else
      ip
    end
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def status=(val)
    write_attribute(:status, STATUSES[val.intern])
  end

  def status
    STATUSES.key(read_attribute(:status))
  end

end
