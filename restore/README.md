
# mfdumprestore

you can stop the docker services and copy the myfinancedata-volume to the new location or an nfs share.
to restore this volume create an empty volume myfinancedata and copy the saved volume-data to it

just in case, if this process is not working due to an hardwarecrash e.G., a job is scheduled that dumps the database every day

to restore a dump:
// jobs are imutable, so you have to delete the old job if it exists:
kubectl delete job.batch/mfrestore

//edit the dump-filename in  deploy.yaml
copy the deploy.yaml to the K8n Server
kubectl apply -f deploy.yaml