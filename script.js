document.getElementById('markdown').addEventListener('input', function () {
    const markdownText = this.value;
    const htmlContent = marked(markdownText);
    document.getElementById('preview').innerHTML = htmlContent;
});
