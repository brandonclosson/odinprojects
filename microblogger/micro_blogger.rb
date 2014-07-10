require 'jumpstart_auth'
require 'bitly'
require 'klout'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing"
    @client = JumpstartAuth.twitter
    Klout.api_key = 'r39vz7jf84fpp93yxu64h6p8'
    Bitly.use_api_version_3
    @bitly = Bitly.new('brandonclosson', 'R_886769f8121c4113bd7147cc186b5d38')
  end

  def followers_list
    @client.followers.collect { |follower| follower.screen_name }
  end

  def tweet(message)
    @client.update(message)
  end

  def dm(target, message)
    followers = followers_list
    return @client.create_direct_message(target, message) if followers.include? target
    puts "ERROR: Someone has to be following you if you're gonna DM them!"
  end

  def spam_my_followers(message)
    followers_list.each { |f| dm(f, message) }
  end

  def everyones_last_tweet
    friends = @client.friends.sort_by { |friend| friend.screen_name.downcase }

    friends.each do |friend|
      timestamp = friend.status.created_at.strftime('%A, %b %d')
      puts "\n#{friend.screen_name}: #{friend.status.text} on #{timestamp}"
    end
  end

  def shorten_url(url)
    @bitly.shorten(url).short_url
  end

  def tweet_with_url(message, url)
    tweet(message + " " + shorten_url(url))
  end

  def calculate_klout(screen_name)
    identity = Klout::Identity.find_by_screen_name(screen_name)
    user = Klout::User.new(identity.id)
    user.score.score
  end

  def all_friends_klout_score
    friends = @client.friends.collect { |f| f.screen_name}
    friends.each do |f|
      klout_score = calculate_klout(f)
      puts "#{f}: #{klout_score} Klout"
    end
  end

  def run
    puts "-------------------------------------------------"
    puts "Welcome to Brandon's command-line twitter client."
    puts "-------------------------------------------------"
    command = ""
    while command != 'q'
      puts "Your options are q for quit, t for tweet, d to dm, s to spam,\nturl to tweet with url, e to print all of your friends latest tweets,\nor k to see all of your friends' klout score!"
      print "Enter a command: "
      input = gets.chomp.downcase
      parts = input.split(" ")
      command = parts[0]

      if parts.size > 1
        message = parts[1..-1].join(" ")
        dm_target = parts[1]
        dm_message = parts[2..-1].join(" ")
        turl_message = parts[1..-2].join(" ")
        turl_url = parts[-1]
      end

      case command
        when 'q' then puts "Terminating twitter client..."
        when 't' then tweet(message)
        when 'd' then dm(dm_target, dm_message)
        when 's' then spam_my_followers(message)
        when 'e' then everyones_last_tweet
        when 'k' then all_friends_klout_score
        when 'turl' then tweet_with_url(turl_message, turl_url)
        else puts "Sorry, I only understand seven commands..."
      end
    end
  end
end

blogger = MicroBlogger.new
blogger.run