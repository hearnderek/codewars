#include <stdlib.h>
#include <string.h>

size_t count_words (const char *words)
{
    // count the number of words
    // this function will be used to allocate the right amount of memory so it has to be correct !
    const size_t len = strlen(words) + 1;
    if (len == 1) {
        return 0;
    }

    size_t wordcount = 0;
    for (size_t i = 0; i < len; ++i) {
        if(words[i] == ' ' || words[i] == '\0') {
            wordcount += 1;
        }
    }
	return wordcount;
}

void words_to_array (const char *words, char *words_array[])
{
    // allocate the words on the heap, they will be freed
    // write them to the pre-allocated words_array

    const size_t len = strlen(words) + 1;
    if (len == 1) {
        return;
    }

    size_t wordcount = 0;
    size_t wordlen = 0;
    size_t wordstart = 0;
    for (size_t i = 0; i < len; ++i) {
        if(words[i] == ' ' || words[i] == '\0') {
            words_array[wordcount] = calloc(wordlen, sizeof(char));
            memcpy(words_array[wordcount], &words[wordstart], wordlen);
            wordcount += 1;
            wordlen = 0;
            wordstart = i + 1;
            continue;
        }

        wordlen += 1;
    }
}