from flask import Flask, jsonify, request, render_template
import pandas as pd

app = Flask(__name__)

# Load dataset once
df = pd.read_csv("assets/artwork_data.csv")

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/results")
def results():
    query = request.args.get("q", "").lower()
    field = request.args.get("field", "title")

    if query == "":
        return render_template("results.html", results=[])

    # Search Logic
    if field in ["title", "artist"]:
        matches = df[df[field].str.lower().str.contains(query, na=False)]
    elif field == "year":
        matches = df[df["year"].astype(str).str.contains(query)]
    else:
        matches = df.head(0)  # fallback empty

    result_dicts = matches.to_dict(orient="records")

    return render_template("results.html", results=result_dicts)

# JSON endpoint
@app.route("/api/search")
def api_search():
    query = request.args.get("q", "").lower()
    field = request.args.get("field", "title")

    if field in ["title", "artist"]:
        matches = df[df[field].str.lower().str.contains(query, na=False)]
    elif field == "year":
        matches = df[df["year"].astype(str).str.contains(query)]
    else:
        matches = df.head(0)

    return jsonify(matches.to_dict(orient="records"))

# Health check endpoint
@app.route("/health")
def health():
    try:
        df.head(1)
        status = {"status": "ok", "df_loaded": True}
    except Exception as e:
        status = {"status": "error", "df_loaded": False, "error": str(e)}
    return jsonify(status)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)


