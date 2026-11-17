# Usertour, official image pinned by version and digest.
# Bump both the tag and the digest together; see CHANGELOG.md.
FROM usertour/usertour:0.9.8@sha256:445e039d380d9eda3d72014f33f068a39df202787e246c2d9062396c325298a7

COPY railway-start.sh /app/scripts/railway-start.sh
RUN chmod +x /app/scripts/railway-start.sh

# The upstream start script runs nginx on $PORT, applies the Prisma
# migrations, seeds, then execs the Node server.
CMD ["/app/scripts/railway-start.sh"]
