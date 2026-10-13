# NFL AI SQL Database

This example models 2026 NFL teams, conferences, head coaches, team captains, and week 1–2 schedules (no scores).

## Overview of the Files
* **db_bot.py**: Builds the SQLite database, asks Grok for SQL, runs it, then asks Grok for a friendly answer.
* **setup.sql**: Tables and foreign keys.
* **setupData.sql**: Sample NFL data.
* **config.json**: Your xAI API key. Do not commit this file.
* **config.example.json**: Safe template you *can* commit.
* **.gitignore**: Keeps `config.json` and the generated sqlite file out of git.
* **responses_\<strategy>_\<time>.json**: Logs of prompts, SQL, and answers.

## API key
Use a regular **API key** from the [xAI API Keys page](https://console.x.ai/team/default/api-keys). That is the inference key for calling Grok from Python. It is not a Management key, and there is no separate “code” key.

Copy `config.example.json` to `config.json` and paste your key:

```json
{
    "xaiKey": "xai-..."
}
```

Then:

```
pip install xai-sdk
python db_bot.py
```

## Prompting Strategies Used
This project tries “zero-shot” and “single-domain double-shot” as outlined in https://arxiv.org/abs/2305.11853
