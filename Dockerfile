FROM ghcr.io/gitroomhq/postiz-app:v2.21.2

# Patch read_insights scope - try all possible quote formats
RUN BACKEND=/app/apps/backend/dist/libraries/nestjs-libraries/src/integrations/social/facebook.provider.js && \
    ORCHESTRATOR=/app/apps/orchestrator/dist/libraries/nestjs-libraries/src/integrations/social/facebook.provider.js && \
    for f in "$BACKEND" "$ORCHESTRATOR"; do \
      if [ -f "$f" ]; then \
        grep -c "read_insights" "$f" && echo "Found in: $f" || echo "NOT found in: $f"; \
        sed -i 's/"read_insights",\?//g' "$f"; \
        sed -i "s/'read_insights',\?//g" "$f"; \
        sed -i 's/,read_insights//g' "$f"; \
        sed -i 's/read_insights,//g' "$f"; \
        grep -c "read_insights" "$f" && echo "STILL has read_insights in: $f" || echo "Cleaned: $f"; \
      else \
        echo "File not found: $f"; \
      fi; \
    done
