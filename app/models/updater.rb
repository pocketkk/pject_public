class Updater

    # Passed object must have a
    #   user
    #   type_of_update + _message  ie  new_message or update_message

    def initialize(object, *args)
        options = args.extract_options!
        raise "Missing update_type" unless @update_type=options[:update_type]
        @msg = options[:message] || object.send("#{@update_type}_message")
        @user= options[:user] || object.user

        define_singleton_method("#{@update_type}_update",
            lambda {
                    update=@user.updates.new;
                    update.feed_item = @msg;
                    update.save
            }
        )

        self.send("#{@update_type}_update")
    end

end
