FROM microsoft/dotnet-framework:4.0-sdk-windowsservercore-1803 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY *.csproj ./
COPY *.config ./
RUN nuget restore

# copy everything else and build app
COPY . ./
RUN msbuild /p:Configuration=Release


FROM microsoft/aspnet:4.0-windowsservercore-1803 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/. ./

