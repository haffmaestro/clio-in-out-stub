namespace :ips do
	task copy: [:environment] do
		User.all.each do |user|
			ip = Ip.new({user_id: user.id, current_ip: user.current_sign_in_ip, last_sign_in_ip: user.last_sign_in_ip})
			ip.save
		end
	end

	#Trial run to test if it works so not to erase actual data
	task convert: [:environment] do
		Ip.all.each do |ip|
			ip.attributes.select {|attr| attr.match(/.*ip$/)}.keys.each do |key|
				if ip[key] != nil
					ip_array = ip[key].split('.').map(&:to_i)
					integer_ip = 0
					exponent = 3
					ip_array.each do |octet|
						integer_ip += octet*256**exponent
						exponent -= 1
					end
					ip[key] = integer_ip.to_s
					ip.save
				end
			end
		end
	end

	task convert_user_ips: [:environment] do
		User.all.each do |ip|
			ip.attributes.select {|attr| attr.match(/.*ip$/)}.keys.each do |key|
				if ip[key] != nil
					ip_array = ip[key].split('.').map(&:to_i)
					integer_ip = 0
					exponent = 3
					ip_array.each do |octet|
						integer_ip += octet*256**exponent
						exponent -= 1
					end
					ip[key] = integer_ip.to_s
					ip.save
				end
			end
		end
	end
end
