---
name: fix-nexus
description: Update Nexus URL patterns to include NEXUS_URL fallback for GitLab to GitHub migration
---

# Nexus URL Migration

## Purpose

Update Nexus URL patterns in Gradle/Groovy files to support the GitLab to GitHub environment variable migration. GitLab used `NEXUS_BASE_URL`, while GitHub uses `NEXUS_URL`. This skill adds a fallback chain to ensure compatibility during the transition.

## Pattern to Fix

**Before:**
```groovy
url = "${System.env.NEXUS_BASE_URL ?: nexusBaseUrl}/nexus/repository/..."
```

**After:**
```groovy
url = "${System.env.NEXUS_BASE_URL ?: System.env.NEXUS_URL ?: nexusBaseUrl}/nexus/repository/..."
```

## Process

1. **Search for affected files**: Find all files containing `System.env.NEXUS_BASE_URL` patterns
2. **Identify patterns**: Locate lines with the pattern `System.env.NEXUS_BASE_URL ?: nexusBaseUrl` (or similar)
3. **Update pattern**: Insert `System.env.NEXUS_URL ?:` between `NEXUS_BASE_URL ?: ` and the final fallback
4. **Verify changes**: Ensure the Elvis operator chain is properly formed
5. **Report results**: List all files modified and the number of changes made

## Key Points

- The fallback chain should be: `NEXUS_BASE_URL` → `NEXUS_URL` → `nexusBaseUrl`
- Preserve all whitespace and formatting around the URL patterns
- Common file types: `.gradle`, `.gradle.kts`, Groovy scripts
- The pattern may appear in multiple contexts (maven-public, custom repositories, etc.)

## Expected Outcome

All Nexus URL references will check for the legacy GitLab variable first, then the new GitHub variable, then fall back to the local default, ensuring seamless migration between CI/CD platforms.
