FROM ghcr.io/gitroomhq/postiz-app:v2.21.2

RUN BACKEND=/app/apps/backend/dist/libraries/nestjs-libraries/src/integrations/social/facebook.provider.js && \
    ORCHESTRATOR=/app/apps/orchestrator/dist/libraries/nestjs-libraries/src/integrations/social/facebook.provider.js && \
    for f in "$BACKEND" "$ORCHESTRATOR"; do \
      if [ -f "$f" ]; then \
        sed -i 's/"read_insights",//g' "$f" && \
        sed -i 's/,"read_insights"//g' "$f" && \
        echo "Patched: $f"; \
      else \
        echo "Not found: $f"; \
      fi; \
    done
