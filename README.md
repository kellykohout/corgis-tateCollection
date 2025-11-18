# corgis-tateCollection
## Executive Summary
**Problem:** Museums across the globe keep large collections of very significant objects. When these collections take inventory or change, it is a significant event, especially for Tate. The Tate "family" is a large collection of art galleries in the UK. If the records are not clear, it is difficult to quickly find what pieces of the collection are still in the museum's posession. Furthermore, the msueum must identify them with more than one piece of information. We must create something for the Tate Museum curators to quickly search through their inventory, and for potential museum visitors for a specific piece or potential partner museums looking to exchange. 
Museum curators, knowledge of collection

**Solution:** Build a simple search tool app where users search by typing in the title of the piece, or the name of the artist, or the year an art piece was created. The search tool will immediately display the matching artwork. Behing the scenes, the app cleans through the dataset of the museum collection.

## System Overview
**Course Concept(s):** Initially a single interactive Bash script that including piping and was committed to a GitHub repo (inspired by Case03). Transitioned in to the final product: Flask app, J-SON endpoints, data ingestion and cleaning, and containerization with Docker (inspired by Case04).

**Architecture Diagram:** Include a PNG in /assets and embed it here

**Data/Modules/Services:** Flask, JSON, pandas, Tate Museum artwork_data.csv from the Tate Museum free-for-use. 

## How to Run (Local)
Choose Docker or Apptainer and provide a single command. Example: (image)

## Design Decisions
**Why this concept?** Initially, the solution was in the form of a single Bash script. However, this approach felt quite 2D. The user had a harder time interacting with the search function and it was slower. The Flask app is faster, more flexible, and more interactive. The current concept allows for more informative results by connecting with the dataset in more than one way. 

**Tradeoffs:** Performance, cost, complexity, maintainability.

**Security/Privacy:** Secrets mgmt, input validation, PH handling.

**Ops:** Logs/metrics, scaling consideration, known limitations.

## Results & Evaluation
Screenshot or sample outputs (place assets in /assets).
Brief performance notes or resource footprint (if relevant). 
Validation/ tests performed and outcomes.

## What’s Next
Planned improvements, refactors, and stretch features.

## Links ( Required)
## Github Repo: <insert repo url>
## Public cloud App (OPTIONAL)

