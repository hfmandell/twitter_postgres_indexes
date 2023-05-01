/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT 
    tag, 
    count(*) as count
FROM (
    SELECT DISTINCT 
        data->>'id' as id_tweets, 
        '#' || (jsonb_array_elements(data->'entities'->'hashtags' || coalesce(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text') as tag
    FROM tweets_jsonb
    WHERE data->'entities'->'hashtags'@@'$[*].text == "coronavirus"' 
       OR data->'extended_tweet'->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
) t
GROUP BY (1)
ORDER BY count DESC, tag
LIMIT 1000;
