# Builder phase, sole purpose of this phase is to install dependencies and build our application
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# /app/build will contain all the files needed for the run phase

# Run phase
# Each FROM command terminates each successive block
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# When we do the above copy step, we're essentially dumping everything else (except build folder) that was created during build phase