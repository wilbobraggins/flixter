FROM ruby:2.6.0
# Copy application
COPY . /flixter
# Change directory
WORKDIR /flixter

# Install gems, nodejs and precompile the assets
RUN bundle install --deployment --without development test \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs

ENV RAILS_ENV development

CMD ["rails", "server", "-b", "0.0.0.0", "-p" "3000"]

ENTRYPOINT ./entrypoint.sh