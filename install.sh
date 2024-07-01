
ENV=test
ENVDIR="envs/$ENV"
BASE_CONFIG="jupyterhub.yaml"
OVERRIDES="$ENVDIR/jupyterhub_overrides.yaml"
OUTPUT="$ENVDIR/jupyterhub.yaml"

./merge-config.py $BASE_CONFIG $OVERRIDES $OUTPUT
cat $OUTPUT
