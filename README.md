# MTA:SA Sentry Integration

## Introduction

**MTA:SA Sentry Integration** is a resource designed to seamlessly capture and log server-side (and optionally client-side) errors in Multi Theft Auto: San Andreas (MTA:SA) using Sentry. This integration helps server administrators track issues in real-time, making debugging and maintenance easier. By leveraging Sentry's powerful logging and alerting system, you can gain better insight into errors and warnings occurring on your server.

This guide will walk you through the installation and configuration process to get Sentry up and running with MTA:SA.

## Installation Guide

### 1. Create a Sentry Project

![Create Project](images/1-create-project)

1. Log in to [Sentry](https://sentry.io/) and create a new project.
2. Select **PHP** as the platform (since MTA:SA is not officially supported).
3. Configure project settings such as **frequency** and **team**.
4. Click **Create Project**.

---

### 2. Configuration

![DSN Configuration](images/2-dsn)

#### Extract and Set DSN Parts

Your DSN URL will look something like this:

```
https://1b32dd438ee813fde848836d713a4987@o4506067536969728.ingest.us.sentry.io/4509063625375744
```

Break it down into the following variables for `meta.xml`:

- **Key**: `1b32dd438ee813fde848836d713a4987`
- **Host**: `o4506067536969728.ingest.us.sentry.io`
- **Project**: `4509063625375744`

#### Additional Configuration Options

| Setting              | Value     | Description |
|----------------------|----------|-------------|
| `logClient`         | `0/1` | Allow logging client-side errors/warnings. Be cautious, as exposing the DSN can allow flooding. |
| `logErrors`         | `0/1` | Enable or disable error logging. |
| `logWarnings`       | `0/1` | Enable or disable warning logging. |
| `msBetweenReports`  | `> 0`     | Set a delay (in milliseconds) between repeated error reports. |

---

### 3. Start the Resource

Run the following commands in the MTA:SA console:


```sh
aclrequest allow mtasa-sentry all
```
```sh
start mtasa-sentry
```
```sh
testsentry
```


This will start the resource and send a test error to verify functionality.

![Test Result](images/3-test-result)

---

### 4. Auto-Start the Resource

To ensure mtasa-sentry starts automatically with the server, add the following line to your mtaserver.conf file:

`<resource src="mtasa-sentry" startup="1" protected="0" />`

This ensures that Sentry integration is active whenever the server runs.

---

Your Sentry setup for MTA:SA should now be up and running!

