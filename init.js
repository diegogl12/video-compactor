db = db.getSiblingDB("video_compactor");

function collectionExists(name) {
    return db.getCollectionNames().includes(name);
}

if (!collectionExists("videos")) {
    db.createCollection("videos");
}