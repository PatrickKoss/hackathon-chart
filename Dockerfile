FROM gcr.io/distroless/static-debian11:nonroot

COPY main /main

ENTRYPOINT ["/main"]
