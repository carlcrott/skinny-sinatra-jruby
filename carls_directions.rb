# modified applicaiton file

# commit to git

heroku create --stack cedar

# made modifications on oscar branch
git push heroku oscar:master


# inserted jar files and added to .gitignore

# runs like a dream
jruby -S trinidad 


# removed crap includes from app.rb
# added requrest_headers method from http://wbear.wordpress.com/2010/03/20/sinatra-request-headers-helper/

def request_headers
  env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
end


$ curl -v -H "Content-Type: application/xml; charset=utf-8" http://localhost:3000/headers

$ curl http://localhost:3000/parse -H "process: To a solution of 3-bromobenzophenone (1.00 g, 4 mmol) in MeOH (15 mL) was added sodium borohydride (0.3 mL, 8 mmol) portionwise at rt and the suspension was stirred at rt for 1-24 h. The reaction was diluted slowly with water and extracted with CH2Cl2. The organic layer was washed successively with water, brine, dried over Na2SO4, and concentrated to give the title compound as oil (0.8 g, 79%), which was used in the next reaction without further purification. MS (ESI, pos. ion) m/z: 247.1 (M-OH)."








# ----------------------- refs ( not run in this programming operation ) ------------------------------

http://chris.chowie.net/2011/08/28/Sinatra-with-JRuby-on-Heroku/

# analyze app
jruby --profile

# build AMIs
http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/creating-an-ami.html?r=1883



