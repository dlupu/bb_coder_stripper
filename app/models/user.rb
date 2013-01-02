class User < ActiveRecord::Base

  self.table_name = "phpbb_users"
  self.primary_key = "user_id"

  def self.sanitize_bb
    nb = 0
    User.where("user_sig != ''").find_in_batches do |group|

        puts '*'
        group.each do  |user|

          user.user_sig = BbCodesStriper.sanitize_bb(user.user_sig)

         if user.changed?
           puts "----------"
           puts user.changes
           puts "----------"

           user.save

           nb += 1
         end


        end
       puts ''
    end

    puts "updated #{nb} users"
  end



end