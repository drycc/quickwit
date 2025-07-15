{{/* Generate quickwit envs */}}
{{- define "quickwit.envs" }}
env:
- name: NAMESPACE
  valueFrom:
    fieldRef:
      fieldPath: metadata.namespace
- name: POD_NAME
  valueFrom:
    fieldRef:
      fieldPath: metadata.name
- name: POD_IP
  valueFrom:
    fieldRef:
      fieldPath: status.podIP
{{- if (.Values.databaseUrl) }}
- name: DRYCC_DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: quickwit-creds
      key: database-url
{{- else if .Values.database.enabled }}
- name: DRYCC_PG_USER
  valueFrom:
    secretKeyRef:
      name: database-creds
      key: user
- name: DRYCC_PG_PASSWORD
  valueFrom:
    secretKeyRef:
      name: database-creds
      key: password
- name: DRYCC_DATABASE_URL
  value: "postgres://$(DRYCC_PG_USER):$(DRYCC_PG_PASSWORD)@drycc-database:5432/quickwit"
{{- end }}
{{- if (.Values.storageEndpoint) }}
- name: "DRYCC_STORAGE_LOOKUP"
  valueFrom:
    secretKeyRef:
      name: quickwit-creds
      key: storage-lookup
- name: "DRYCC_STORAGE_BUCKET"
  valueFrom:
    secretKeyRef:
      name: quickwit-creds
      key: storage-bucket
- name: "DRYCC_STORAGE_ENDPOINT"
  valueFrom:
    secretKeyRef:
      name: quickwit-creds
      key: storage-endpoint
- name: "DRYCC_STORAGE_ACCESSKEY"
  valueFrom:
    secretKeyRef:
      name: quickwit-creds
      key: storage-accesskey
- name: "DRYCC_STORAGE_SECRETKEY"
  valueFrom:
    secretKeyRef:
      name: quickwit-creds
      key: storage-secretkey
{{- else if .Values.storage.enabled  }}
- name: "DRYCC_STORAGE_LOOKUP"
  value: "path"
- name: "DRYCC_STORAGE_BUCKET"
  value: "quickwit"
- name: "DRYCC_STORAGE_ENDPOINT"
  value: http://drycc-storage:9000
- name: "DRYCC_STORAGE_ACCESSKEY"
  valueFrom:
    secretKeyRef:
      name: storage-creds
      key: accesskey
- name: "DRYCC_STORAGE_SECRETKEY"
  valueFrom:
    secretKeyRef:
      name: storage-creds
      key: secretkey
{{- end }}
- name: QW_CLUSTER_ID
  value: drycc-quickwit
- name: QW_NODE_ID
  value: "$(POD_NAME)"
- name: QW_PEER_SEEDS
  value: drycc-quickwit
- name: QW_ADVERTISE_ADDRESS
  value: "$(POD_IP)"
- name: QW_CLUSTER_ENDPOINT
  value: http://drycc-quickwit-metastore:7280
{{- end }}

{{/* Generate quickwit ports */}}
{{- define "quickwit.ports" -}}
ports:
- name: rest
  containerPort: 7280
  protocol: TCP
- name: grpc
  containerPort: 7281
  protocol: TCP
- name: discovery
  containerPort: 7282
  protocol: UDP
{{- end }}
