const contentTypes = {
    "pdf": "application/pdf",
    "text": "text/plain",
    "csv": "text/csv",
    "html": "text/html",
    "json": "application/json",
}

const getContentType = (ext) => {
    return contentTypes[ext] || "text/plain"
}

module.exports = {
    contentTypes,
    getContentType
}