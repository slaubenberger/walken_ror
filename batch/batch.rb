#!/usr/bin/env ruby
# encoding: utf-8

# The program takes an initial path to scan
# for movie files
#
# Author::    Stefan Laubenberger  (mailto:laubenberger@gmail.com)
# Copyright:: Copyright (c) 2012 Lurking in the dark LLC
# License::   GPLv2
require "#{File.dirname(__FILE__)}/../config/environment.rb"

class Scanner < Struct.new(:counter, :size)
  attr_reader :path, :counter, :size

  def initialize path
    @path = path

    puts "Selected directory: " + @path
  end
  
  # Scan directory
  def scan
    puts "Scanning directory: " + @path

    user = User.find_or_initialize_by_email("testi@gmail.com")
    user.update_attributes({name: "Testi", email: "testi@gmail.com", password: "muhlimuh", password_confirmation: "muhlimuh"})
    user.save

    userImdb = User.find_or_initialize_by_email("imdb@gmail.com")
    userImdb.update_attributes({name: "IMDB", email: "imdb@gmail.com", password: "123456", password_confirmation: "123456"})
    userImdb.save

    @counter = 0
    @size = 0

    Dir[@path + "**/*.{avi, mpg, m2ts, mkv}"].each do |filename| 
      next if File.directory? filename # only files are relevant

      name = filename.split("/").last.split(".").first 
      
      puts name
      
      begin
	imdb = Imdb::Search.new(name).movies.first
      rescue
	puts "+++++++++++++++ BAD! ++++++++++++++++++"
      else
	movie = Movie.find_or_initialize_by_imdb_id(imdb.id)
	movie.update_attributes({name: imdb.title, imdb_id: imdb.id})
	movie.save

	#puts "IMDB: #{imdb.title} - #{imdb.id} - #{imdb.poster}"
	
	movieFile = MovieFile.find_or_initialize_by_movie_id(movie.id)
	movieFile.update_attributes({movie_id: movie.id, user_id: user.id, path: filename})
	movieFile.save
      end
      
      @counter += 1
      @size += File.size filename
    end
    
    puts "User: #{user.id}"
    puts "User IMDB: #{userImdb.id}"
  end
end
=begin
                    if filename.endswith(FILE_ENDINGS):
                        path = ('%s/%s' % (dirpath, filename)).replace('//', '/')
                        
                        # handle file only case
                        name = filename

                        # handle 0000n.m2ts case
                        if name[:4] == '0000':
                            dirs = dirpath.split('/')
                            name = dirs[-3]
                        
                        # remove fileendings
                        for ending in FILE_ENDINGS:
                            name = name.replace(ending, '') 
                        
                        # remove (..) stuff
                        desc = re.search(r'\(.*\)', name)
                        if desc:
                            desc = desc.group().replace('(', '').replace(')', '')
                        name = re.sub(r'\(.*\)', '', name)    
                        
                        # get more movie data
                        try:
                            tmovie = tmdb.Movie(name)
                        except (ValueError, requests.exceptions.ConnectionError), e:
                            print 'GIVE UP %s' % name
                            continue

                        # try to get original name
                        try:
                            name = tmovie.get_original_title()
                        except IndexError, e:
                            pass

                        # try to get original name
                        try:
                            movie_id = tmovie.get_id()
                            imdb_id = tmovie.get_imdb_id(movie_id)
                        except IndexError, e:
                            imdb_id = None

                        # create movie, if not exists
                        movie, created = Movie.objects.get_or_create(name=name, imdb_id=imdb_id)
                        print name

                        # create file object
                        fil, created = File.objects.get_or_create(path=path, user=user, movie=movie)
                        fil.desc = desc
                        fil.save()

                        # try to get vote average
                        try:
                            movie_id = tmovie.get_id()
                            vote_average = tmovie.get_vote_average(movie_id)
                            rating, created = Rating.objects.get_or_create(movie=movie, user=tmoviedb_user)
                            rating.rating = "%s" % vote_average
                            rating.save()
                        except IndexError, e:
                            pass
=end
scanner = Scanner.new "/shares/nas/public/video/movies/_english"
scanner.scan

puts "Files found: #{scanner.counter.to_s}"
puts "Size: #{scanner.size.to_s}"