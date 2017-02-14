web: puma -e production -b unix://$SOCKET
worker: sidekiq -e production -L /app/log/sidekiq.log