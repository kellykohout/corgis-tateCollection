import pandas as pd

# Load your full dataset
df = pd.read_csv("artwork_raw.csv")

# Select only the columns you want
new_df = df[["title", "artist", "year", "thumbnailUrl"]].copy()

# Insert "media" after "www"
# Replace: http://www.tate.org.uk → http://www.media.tate.org.uk
new_df["thumbnailUrl"] = new_df["thumbnailUrl"].str.replace(
    "http://www.tate.org.uk",
    "https://media.tate.org.uk",
    regex=False
)

# Save to a new CSV file
new_df.to_csv("artwork_data.csv", index=False)

print("New CSV created: artwork_data.csv")
