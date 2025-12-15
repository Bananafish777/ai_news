--
-- PostgreSQL database dump
--

\restrict FXlnJAsfOIpLWRraqjXvZ3hsXI1E6O4KCxgZmSGCedhDxaB6YRBIh4bWAQbiAVI

-- Dumped from database version 16.11 (Debian 16.11-1.pgdg13+1)
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: newsapp
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO newsapp;

--
-- Name: crawl_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.crawl_status AS ENUM (
    'finished',
    'progressing',
    'failed'
);


ALTER TYPE public.crawl_status OWNER TO postgres;

--
-- Name: media_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.media_type AS ENUM (
    'video',
    'image',
    'cover',
    'thumbnail'
);


ALTER TYPE public.media_type OWNER TO postgres;

--
-- Name: notification_level; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.notification_level AS ENUM (
    'message',
    'site',
    'none'
);


ALTER TYPE public.notification_level OWNER TO postgres;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'user',
    'admin',
    'editor'
);


ALTER TYPE public.user_role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: article_contents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.article_contents (
    article_id bigint NOT NULL,
    content text,
    url text NOT NULL
);


ALTER TABLE public.article_contents OWNER TO postgres;

--
-- Name: article_medias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.article_medias (
    id bigint NOT NULL,
    article_id bigint NOT NULL,
    url text NOT NULL,
    size integer,
    type public.media_type,
    reference text,
    "position" integer
);


ALTER TABLE public.article_medias OWNER TO postgres;

--
-- Name: article_medias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.article_medias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.article_medias_id_seq OWNER TO postgres;

--
-- Name: article_medias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.article_medias_id_seq OWNED BY public.article_medias.id;


--
-- Name: articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.articles (
    id bigint NOT NULL,
    source_id bigint,
    title text NOT NULL,
    url text NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    create_time timestamp without time zone DEFAULT now() NOT NULL,
    delete_time timestamp without time zone,
    author text
);


ALTER TABLE public.articles OWNER TO postgres;

--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.articles_id_seq OWNER TO postgres;

--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: bookmark; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookmark (
    user_id bigint NOT NULL,
    article_id bigint NOT NULL,
    create_at timestamp without time zone DEFAULT now() NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.bookmark OWNER TO postgres;

--
-- Name: crawl_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crawl_job (
    id bigint NOT NULL,
    source_id bigint NOT NULL,
    start_time timestamp without time zone DEFAULT now() NOT NULL,
    end_time timestamp without time zone,
    status public.crawl_status DEFAULT 'progressing'::public.crawl_status NOT NULL,
    message text
);


ALTER TABLE public.crawl_job OWNER TO postgres;

--
-- Name: crawl_job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.crawl_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.crawl_job_id_seq OWNER TO postgres;

--
-- Name: crawl_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.crawl_job_id_seq OWNED BY public.crawl_job.id;


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: newsapp
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO newsapp;

--
-- Name: follows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.follows (
    user_id bigint NOT NULL,
    topic_id bigint NOT NULL,
    create_time timestamp without time zone DEFAULT now() NOT NULL,
    notification_level public.notification_level DEFAULT 'site'::public.notification_level NOT NULL
);


ALTER TABLE public.follows OWNER TO postgres;

--
-- Name: history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.history (
    user_id bigint NOT NULL,
    article_id bigint NOT NULL,
    first_seen timestamp without time zone DEFAULT now() NOT NULL,
    last_seen timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.history OWNER TO postgres;

--
-- Name: sources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sources (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    url text NOT NULL,
    api text NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    create_time timestamp without time zone DEFAULT now() NOT NULL,
    delete_time timestamp without time zone
);


ALTER TABLE public.sources OWNER TO postgres;

--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sources_id_seq OWNER TO postgres;

--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sources_id_seq OWNED BY public.sources.id;


--
-- Name: topic_articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topic_articles (
    topic_id bigint NOT NULL,
    article_id bigint NOT NULL,
    assigned_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.topic_articles OWNER TO postgres;

--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topics (
    id bigint NOT NULL,
    keyword text,
    is_deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.topics OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.topics_id_seq OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(254) NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    role public.user_role DEFAULT 'user'::public.user_role NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: article_medias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article_medias ALTER COLUMN id SET DEFAULT nextval('public.article_medias_id_seq'::regclass);


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: crawl_job id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crawl_job ALTER COLUMN id SET DEFAULT nextval('public.crawl_job_id_seq'::regclass);


--
-- Name: sources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sources ALTER COLUMN id SET DEFAULT nextval('public.sources_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: article_contents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.article_contents (article_id, content, url) FROM stdin;
1	The oil tanker seized by the United States off the coast of Venezuela this week was part of the Venezuelan government’s effort to support Cuba, according to documents and people inside the Venezuelan oil industry.\n\nThe tanker, which is called Skipper, left Venezuela on Dec. 4, carrying nearly two million barrels of the country’s heavy crude, according to internal data from Venezuela’s state oil company, known as PDVSA. The ship’s destination was listed as the Cuban port of Matanzas, the data shows.\n\nTwo days after its departure, Skipper offloaded a small fraction of its oil, an estimated 50,000 barrels, to another ship, called Neptune 6, which then headed north toward Cuba, according to the shipping data firm Kpler. After the transfer, Skipper headed east, toward Asia, with the vast majority of its oil on board, according to a U.S. official briefed on the matter.\n\nPresident Nicolás Maduro of Venezuela and his predecessor, Hugo Chávez, have for decades sent oil to Cuba at highly subsidized prices, providing a crucial resource at low cost to the impoverished island.\nIn return, the Cuban government over the years has sent tens of thousands of medics, sports instructors and, increasingly, security professionals on assignments to Venezuela. That exchange has assumed special importance as Mr. Maduro has leaned on Cuban bodyguards and counterintelligence officers to protect himself against the U.S. military buildup in the Caribbean.\nIn recent years, however, only a fraction of Venezuelan oil set aside for Cuba has actually reached the island, according to PDVSA documents and tanker tracking data.\n\nMost of the oil allocated for Cuba has instead been resold to China, with the money providing badly needed hard currency for the Cuban government, according to multiple people close to the Venezuelan government.\n\nSome of that money is believed to have been used by Cuban officials to purchase basic goods, though the opacity of the country’s economy makes it difficult to estimate where that money ends up, or how it is spent, or how much goes to business intermediaries with ties to both governments.\nOn Friday, Cuban officials condemned the American seizure of the tanker, calling it in a statement an “act of piracy and maritime terrorism” that hurts Cuba and its people.\n“This action is part of the U.S. escalation aimed at hampering Venezuela’s legitimate right to freely use and trade its natural resources with other nations, including the supplies of hydrocarbons to Cuba,” the statement said.\n\nThe White House did not immediately respond to a request for comment.\n\nThe main person managing the flow of oil between Cuba and Venezuela is a Panamanian businessman named Ramón Carretero, who in the past few years has become one of the largest traders of Venezuelan oil, according to PDVSA data and people close to Venezuela’s government.\n\nThe U.S. Treasury Department imposed sanctions on Mr. Carretero on Thursday for “facilitating shipments of petroleum products on behalf of the Venezuelan government.” Mr. Carretero, through a legal representative, declined to comment on the government’s decision. He did not respond to detailed questions for this article.\n\nMr. Carretero’s role as an economic intermediary between Cuba and Venezuela was first reported by Armando.info, a Venezuelan investigative news outlet.\nSkipper, the seized tanker, was carrying oil jointly contracted by Cubametales, Cuba’s state-run oil trading firm, and an oil trading company tied to Mr. Carretero, PDVSA documents show. Overall, Mr. Carretero’s trading companies have accounted for a quarter of the oil allocated by PDVSA for export this year, the documents show.\n\nCubametales has won contracts to buy about 65,000 barrels a day of Venezuelan oil so far this year, a 29 percent increase from 2024, and a sevenfold increase from 2023, according to PDVSA documents. The U.S. Treasury imposed sanctions on Cubametales in 2019 for buying Venezuelan oil, a move that formed part of Mr. Trump’s previous standoff with Mr. Maduro during his first administration.\n\nThe oil from Venezuela that does reach Cuba generates electricity and provides fuel for airplanes and machinery. But it is not enough to prevent widespread power outages that have plagued the island amid a broader economic crisis.\n\nSkipper’s planned voyage shows how, in practice, Cuba benefits from oil trade in Venezuela. Cubametales, the state-run firm, listed the ship’s destination as Cuba, suggesting that all of the company’s allocated 1.1 million barrels were heading to the island.\n\nThe tanker, however, ultimately headed to China after offloading only a small fraction of the oil to the Neptune 6 and sending it en route to Cuba, according to a person close to PDVSA.\nThen, on Wednesday, as Skipper sailed east in international waters between the islands of Grenada and Trinidad, it fell into a U.S. ambush.\n\nArmed American law enforcement agents wearing camouflaged combat gear rappelled from a helicopter onto the tanker’s deck on Wednesday, according to a video released by the U.S. government and a U.S. official with knowledge of the operation. The crew offered no resistance, and U.S. officials said there were no casualties.\n\nU.S. officials said they would seek a warrant to seize the oil, valued at tens of millions of dollars, adding that the crew had agreed to sail the vessel under Coast Guard supervision to a U.S. port, likely Galveston, Texas.\nThe Trump administration and the Venezuelan opposition have long presented Mr. Maduro’s government as a hub for American adversaries, and the dramatic seizure of the Skipper on Wednesday appeared aimed as much at weakening Mr. Maduro’s alliances as it was at cutting his access to funds.\nVenezuela’s communications minister, Freddy Ñáñez, called the detention of the tanker the latest example of Washington’s “piracy, kidnapping, theft of private property, extrajudicial executions in international waters.” He did not comment on the detailed questions sent for this article.\n\nThe history of Skipper’s voyages points to a larger, looser network connecting the energy industries of Venezuela, Cuba, Iran and Russia, the four American adversaries that have been, to various degrees, shut out from the formal global oil market by Washington’s sanctions.\n\nSkipper’s crew of about 30 sailors was mostly Russian, a U.S. official said.\n\nBefore shipping Venezuelan oil, Skipper spent four years as part of Iran’s covert fleet, transporting Iranian oil to Syria and China, according to data from Kpler, the shipping data firm, and a senior Iranian oil ministry official, who discussed sensitive issues on condition of anonymity.\n\nIran’s foreign ministry spokesman Esmail Baghaei on Friday condemned Skipper’s seizure, calling it “state sponsored piracy” in comments to local media.\nElsewhere in Venezuela, Iranian contractors have worked on repairing the country’s two main refineries, El Palito and Amuay, according to Homayoun Falakshahi, Kpler’s head oil analyst and an expert on Iran’s energy sector.\nRussia supplies Venezuela with key imports of naphtha, a light oil product that Venezuela uses to dilute its sludgy main type of crude and make it suitable for export. A Russian state-run oil company, Rosneft, produces nearly 100,000 barrels a day of crude in Venezuela, and in previous years the company had played a crucial role in exporting Venezuelan oil to China.\n\nThese countries’s energy ties have been driven less by shared anti-American sentiment than by commercial opportunities and necessity, according to experts. They have learned from each other how to avoid sanctions and keep oil revenues flowing.\n\nRussia’s ability to build a shadow fleet of tankers and find new oil markets to fund its war in Ukraine, for example, is partly owed to its oil traders’ experience moving sanctioned Venezuelan crude during Mr. Trump’s previous standoff with Mr. Maduro in 2019.\n\nVenezuela, for its part, has learned from Iran, which has worked to evade sanctions imposed by the first Trump administration after it pulled out of the nuclear deal in 2018.\nVenezuela, Iran and Russia, however, also compete for the Chinese oil market, whose size and clout have allowed it to continue buying crude sanctioned by the United States, said Francisco J. Monaldi, an oil expert at Rice University in Houston.\n\n“It’s like the OPEC of sanctions: These countries have common interests, but also some opposing interests,” Mr. Monaldi said. “Most of the time, it’s just about business.”\n\nEric Schmitt and Riley Mellen contributed reporting. Sheelagh McNeill contributed research.	https://www.nytimes.com/2025/12/12/world/americas/venezuela-cuba-oil-tanker.html?smid=url-share
2	\nAuthor: Aaron Blake\n\nThe Indiana state Senate’s vote against a new congressional map that President Donald Trump had pressured it to adopt is one of the most extraordinary examples to date of Republicans standing up to Trump.\n\nBut it wasn’t even the only example Thursday.\n\nIndeed, Trump got a series of brushback pitches in his efforts to dominate his party and American politics.\n\nThe day seemed to reinforce the emerging limits of Trump’s ability to force others to bow to him, as his poll numbers drop and he trends towards lame-duck status.\n\nIndiana rejects redistricting pressure\nIndiana was certainly the biggest example. Despite months of pressure from Trump and his allies, those Republican state senators made a statement. A majority (21) of them (40) actually voted against Trump’s position, defeating the map pretty resoundingly.\n\nThey were facing the president’s promises to unseat them in primaries, pressure from Vice President JD Vance and House Speaker Mike Johnson and a large number of physical threats. (Law enforcement officials have not linked the threats to any group or campaign.)\nIn other words, these Republicans would have known precisely the potentially severe costs of their votes — and a majority of them still voted against Trump.\n\nThe vote was also significant in another way: It might have put a nail in the coffin of Trump’s big redistricting push. Without gaining two favorable districts in Indiana (as the map proposed), Trump’s bare-knuckle push for states to gerrymander in the middle of the decade to help the GOP next year looks to be fizzling.\nRepublicans might gain an advantage in a handful of seats, but it’s looking more and more like it will be pretty close to a wash.\n\nFailure to indict James (again)\nBut we shouldn’t lose sight of the other big developments that went against Trump on Thursday.\n\nIn Virginia, the Justice Department failed for a second time to secure a re-indictment of New York Attorney General Letitia James. The two failed attempts have come after a judge dismissed an initial indictment because the US attorney who secured it wasn’t serving legally.\nJust to emphasize: This is not normal. In a full year between October 2012 and September 2013, federal grand juries rejected indictments only five times nationwide – out of 165,000 cases. They’ve now done it twice in the James case alone.\nAll of this comes after another grand jury also rejected a charge against former FBI Director James Comey, another of Trump’s targets for retribution, in his initial indictment.\n\nThe emerging picture seems to confirm just how thinly constructed the allegations in Trump’s retribution campaign are. And the whole thing, much like his redistricting effort, looks like it could be fizzling because an institution — in this case, the criminal justice system — isn’t bowing to his will.\n\nMore GOP lawmakers break with Trump\nThe story is similar with Trump’s efforts to target Democrats who warned military service-members about the Trump administration potentially giving illegal orders. Trump accused a half-dozen Democrats like Sen. Mark Kelly of Arizona of seditious and even treasonous behavior, and he even invoked the death penalty.\n\nBut Trump’s retaliation efforts there also suffered a major blow Thursday. After the Navy delivered a report on Kelly that Defense Secretary Pete Hegseth had requested, Senate Armed Services Chairman Roger Wicker signaled to CNN that there was no there there.\nThe Mississippi Republican said it wasn’t appropriate for the military to even try to punish Kelly, much less sanction him for sedition or treason.\n\nAnd Indiana wasn’t even the only legislature to deliver Trump a rebuke on Thursday. So too did the US House, where 20 House Republicans voted to overturn Trump’s executive order that stripped federal workers of collective bargaining rights.\nWhile the legislation appears unlikely to become law, it’s rare for Republicans to vote so directly against something Trump wants or has done. And those voting against him weren’t just moderates.\n\nAnd finally, there’s another key debate in Washington where lawmakers appear to be on a very different page from Trump – and don’t seem to be moving, despite his efforts.\nNews broke Thursday that Trump was nominating Lindsey Halligan, who was disqualified in the James and Comey cases, to be confirmed as US attorney. Her confirmation would give her power to seek these kinds of indictments for Trump.\nThere’s a big problem, though: Under its longstanding “blue slip” rule, the Senate doesn’t confirm nominees like her unless they have the approval of senators in the state at issue. And Virginia has two Democratic senators who will not give Halligan such approval.\n\nTrump’s been waging a longstanding pressure campaign to get Senate GOP leadership to scrap this rule, which he also re-upped Thursday on social media.\nBut his renewed push was met with a pretty quick dismissal by key Republicans. Senate Majority Leader John Thune said there are “way more Republican senators who are interested in preserving that [rule] than those who aren’t.” Senate Judiciary Chairman Charles Grassley, meanwhile, suggested the real problem was that the White House wasn’t sending him enough nominees for judiciary posts.\n\nThe episode encapsulated an emerging trend with Trump in which he seems to just throw something at the wall and hope it sticks.\nBut that doesn’t seem to be serving him as well anymore, particularly as institutions and even his fellow Republicans summon some willpower and courage to resist him.\nAnd Thursday was a pretty bad day for Trump on that front.\n	https://www.cnn.com/2025/12/12/politics/power-limitations-trump-analysis
4	\nAuthor: Sarah Ferris\n\nCongressional Republicans are taking a major political gamble this week, laying out a GOP health care agenda that ignores the soon-to-expire enhanced subsidies that help tens of millions of Americans afford Obamacare — despite pleas from some in their own party.\n\nTop Republicans didn’t come to the decision easily. As recently as last week, it wasn’t clear whether GOP leaders in either chamber would offer their own health care plans alongside a high-profile Democratic push to extend those Covid-era Obamacare subsidies.\n\nThere are plenty of frustrated rank-and-file members still trying to convince Republican leaders to change course and offer a short-term fix for the subsidies. Multiple battleground Republicans are plotting how they can intervene, including lobbying President Donald Trump directly or potentially going around their own leadership to force a vote on extending the subsidies, multiple sources told CNN. While they say Obamacare is rife with problems, they insist Republicans can’t simply allow huge premium hikes for millions of people – especially in an election year.\n\n“I support an extension. I don’t want to see us go off this cliff in two and a half weeks. And I support reforms,” said GOP Sen. Lisa Murkowski, minutes after the two parties’ dueling health care proposals failed in the Senate on Thursday.\n\nRep. Nicole Malliotakis, a centrist from New York, said her next step is to “appeal to the White House.”\n\nIf the enhanced subsidies lapse, enrollees will see their premium payments more than double — or about $1,000 — on average, according to KFF, a nonpartisan health policy research group. And roughly 2 million more people are expected to be uninsured next year if they lapse, according to the Congressional Budget Office.\n\nBut for now, Senate Majority Leader John Thune and his House counterpart, Speaker Mike Johnson, have opted for health care measures that seek to address rising costs without tackling the contentious subsidies. And Trump, for now, is staying out of the fray.\n\nThune pushed back against criticism from his own party that Republicans will face blowback if the enhanced subsidies expire at the year’s end and criticized Democratic leaders for reining in their centrist members’ efforts to find a bipartisan path forward.\n\nThe focus on health care comes as both parties are eager to show voters that they’re tackling rising costs for everyday Americans, with GOP leaders in Congress under intense pressure to show real progress soon. But Republicans on Capitol Hill are limited in what they can do with their slim majorities, and GOP chairs in both chambers are opting to focus on years-old ideas like expanding health savings accounts with broad support in the party.\n\nIn the Senate, Republicans on Thursday attempted to pass a bill to expand health savings accounts to help people in certain Obamacare plans afford care. It failed as expected. The plan, from top GOP chairmen Bill Cassidy and Mike Crapo, would funnel money for two years into health savings accounts for certain lower-income and middle class Americans and resume federal funding of Obamacare’s cost-sharing subsidies.\n\nThe chamber also voted on a similarly partisan bill from Democrats, which would fund three more years of Covid-era subsidies that have allowed low-income Americans to obtain coverage with $0 or near $0 monthly premiums while allowing many middle-class consumers to qualify for aid for the first time. It, too, failed to advance. Four Republicans backed advancing the Democratic plan: Murkowski, Susan Collins, Dan Sullivan and Josh Hawley.\n\nWith support for the proposals falling largely along party lines, Congress is days away from the expiring subsidies with no real solution in sight. For weeks, moderates have argued the only way to avert the hikes is a bipartisan deal: Republicans voting to extend subsidies for the first time, and Democrats acknowledging problems like rising costs and some fraud.\n\nSome centrists hope bipartisan work can begin after the failed votes. But GOP leadership — particularly Johnson — has been unwilling to have that fight among their ranks. Johnson said, “We just can’t get Republican votes on that for lots of reasons,” and criticized discharge-petition efforts by moderates such as Rep. Brian Fitzpatrick.\n\nInside the House GOP, views on subsidies diverge. Some hardliners showed openness to a short extension, but there’s no consensus on duration or approach. Vulnerable Republicans like Rep. Kevin Kiley warned of political consequences if Congress leaves without addressing the expiration.\n\nExactly which plans will get a vote in the House is still TBD. Leadership signaled they’ll search for consensus on a slate focused on HSAs and cost-sharing reductions. For now, Trump and the GOP still lack a unified health care agenda eight years after the failed repeal-and-replace push.\n	https://www.cnn.com/2025/12/11/politics/health-care-vote-republicans-congress-obamacare?iid=cnn_buildContentRecirc_end_recirc&recs_exp=up-next-article-end&tenant_id=related.en
6	\nAuthor: Jonathan Head, Matt Spivey\n\nFighting between Thai and Cambodian forces continued early on Saturday hours after US President Donald Trump said the two countries had agreed to a ceasefire.\n\nThai Prime Minister Anutin Charnvirakul said he told the US president a ceasefire would only be possible after Cambodia had withdrawn all its forces and removed landmines. “Thailand will continue to perform military actions until we feel no more harm and threats to our land and people,” he said on social media.\n\nShelling continued overnight as Thai forces pushed to take vantage points along the border. At least 21 people have died in the renewed fighting and 700,000 have been evacuated on both sides.\n\nTrump wrote on social media after speaking to both prime ministers that the two countries had agreed to “cease shooting effective this evening” and revert to the agreement they signed in October before the US president. However, Anutin said Thailand was not the aggressor and Cambodia must first withdraw and remove landmines.\n\nOn Saturday Cambodia reported further Thai air strikes, saying two F-16s dropped seven bombs on targets in Cambodia. Thailand also confirmed fighting continued.\n\nThe long-standing border dispute escalated on 24 July as Cambodia launched rocket barrages into Thailand, which responded with air strikes. After days of intense fighting the neighbours agreed in October to an “immediate and unconditional ceasefire” brokered by Trump and Malaysia’s Anwar Ibrahim. Both sides later accused each other of violations, including newly laid landmines that Thailand says cost seven soldiers their limbs, while Cambodia claims the mines date to the 1980s civil war.\n\nThis week, Thailand launched air strikes inside Cambodia after two Thai soldiers were injured in a skirmish; Cambodia responded with rockets. The clashes have affected six provinces in north-eastern Thailand and six in Cambodia’s north and north-west.\n\nThe countries have contested their 800 km land border for more than a century, drawn by French cartographers in 1907 when France ruled Cambodia.\n	https://www.bbc.com/news/articles/cd0kkyx3vvxo
7	\nAuthor: Guardian staff and agencies\n\nWith health insurance premiums set to rise sharply for at least 22 million Americans who use Affordable Care Act (ACA) tax credits that expire at year end unless Congress acts, House speaker Mike Johnson unveiled a Republican alternative late Friday.\n\nRepublicans refuse to extend the enhanced subsidies created during the Covid era, arguing instead for measures to “tackle drivers of health care costs”. Johnson assembled a package for consideration next week as the House spends its final 2025 work days on health care.\n\nThe 100-plus-page plan focuses on expanding access to employer-linked coverage through association health plans and adding transparency requirements on pharmacy benefit managers (PBMs). It also mentions cost-sharing reductions for some lower-income Obamacare enrollees, but not until January 2027. The package does not extend the expiring enhanced tax credits, which could leave most families facing more than double their current premiums in 2026.\n\nDemocrats pushed votes this week on a three-year extension of enhanced credits, while Senate Republicans floated alternatives; neither plan advanced. Vulnerable House Republicans now face pressure in battleground districts. Some centrists are aligning with Democrats to pursue temporary extensions via discharge petitions. One petition led by GOP Rep. Brian Fitzpatrick proposes a two-year extension with anti-fraud provisions and PBM restrictions; another from Democrat Josh Gottheimer seeks a one-year extension with new income caps. A separate Democratic petition for a three-year “clean” extension has 214 signatures but no Republican support.\n\nDonald Trump said Republicans will “figure out a better plan than Obamacare,” promoting stipends to Americans to buy insurance, but offered few details; Senate GOP proposals referenced $1,000 HSA payments for adults ($1,500 for ages 50–64), sums unlikely to cover even a month of some 2026 premium increases. It appeared there were no such HSA payments in the new House plan.\n\nWith days left in the session and no consensus solution, House leaders plan votes on their package next week while centrists continue attempts to force votes on subsidy extensions.\n	https://www.theguardian.com/us-news/2025/dec/12/house-republicans-health-insurance-plan
8	\nAuthor: Iris Kim\n\nOn a frigid December day, staff from the Street Vendor Project canvassed Bronx commercial corridors, handing out “know your rights” flyers and whistles to fruit-and-vegetable vendors alarmed by videos of immigration raids. Under the Trump administration’s 2025 crackdown, ICE has made 7,488 arrests in New York, and vendors—96% of whom are immigrants, with 27% of mobile food vendors undocumented—say they feel targeted.\n\nOrganizers describe a multilayered rapid-response network. NYC Ice Watch and allied groups use social channels and word-of-mouth to warn neighborhoods, sometimes blocking ICE vehicles before operations launch. After October detentions around Manhattan’s Chinatown, volunteers expanded trainings, partnered with small businesses to offer shelter during raids, and launched “hire-a-vendor” programs to support income.\n\nAdvocates note that enforcement fears compound longstanding pressure from NYPD and sanitation sweeps, plus the city’s vendor-permit cap that pushes sellers into “regulatory shadows.” Some vendors report fewer customers as immigrant neighborhoods spend less time outdoors.\n\nCoalitions such as Hands Off NYC are scaling “Know Your Rights” trainings that draw thousands and organizing “Weekends of Action” to build block-by-block response capacity amid concern over possible National Guard deployment. Despite the risks, volunteers say participation is surging—evidence, they argue, that “there’s power in numbers” to keep New Yorkers working on the streets safer.\n	https://www.theguardian.com/us-news/2025/dec/12/new-york-street-vendors-ice-national-guard
9	\nAuthor: Agencies\n\nWNBA star Caitlin Clark made her senior Team USA debut at a Duke training camp under new head coach Kara Lawson and called the ongoing WNBA CBA talks “the biggest moment the WNBA has ever seen.” Clark said players will “fight for everything we deserve” while emphasizing the need to keep playing for fans and the league’s growth.\n\nKey sticking points include salaries and revenue sharing. The deadline—extended twice from 30 October—now stands at 9 January. Clark, entering her third season with the Indiana Fever, said she is learning the issues from Team USA managing director Sue Bird and Fever teammate Brianna Turner, who is on the negotiating committee. She urged compromise from both sides and stressed that finding a way to play next season is crucial for players, fans, and the league’s momentum.\n	https://www.theguardian.com/sport/2025/dec/12/caitlin-clark-wnba-cba-team-usa-debut-lawson
11	BRUSSELS, Dec 12 (Reuters) - The European Union agreed on Friday to indefinitely freeze Russian central bank assets held in Europe, removing a big obstacle to using the cash to help Ukraine defend itself against Russia.\n\nThe EU wants to keep Ukraine financed and fighting as it sees Russia's invasion as a threat to its own security. To do so, EU states aim to put to work some of the Russian sovereign assets they immobilised after Moscow's 2022 invasion of Ukraine.\n\nA first big step, which EU governments agreed on Friday, is to immobilise 210 billion euros ($246 billion) worth of Russian sovereign assets for as long as needed instead of voting every six months on extending the asset freeze. This removes the risk that Hungary and Slovakia could one day refuse to roll over the freeze.\n\nThe indefinite asset freeze is meant to help convince Belgium to support the EU's plan to use the frozen Russian cash to extend a loan of up to 165 billion euros to Ukraine to cover its military and civilian budget needs in 2026 and 2027. The loan would be paid back by Ukraine only when Russia pays Kyiv war damages, making the loan effectively a grant that advances future Russian reparations payments.\n\nEU leaders are to meet on December 18 to finalise details of the reparations loan and resolve remaining problems, including guarantees for Belgium that it would not be left alone to foot the bill should a potential Moscow lawsuit prove successful.\n\nBefore that, Ukrainian President Volodymyr Zelenskiy will visit Berlin for talks with German Chancellor Friedrich Merz on Monday, with further European, EU and NATO leaders joining later, the German government said.\n\nUkrainian Prime Minister Yulia Svyrydenko praised the decision as a "landmark step toward justice and accountability".\n\nGermany sees no alternative to the reparations loan and would provide 50 billion euros in guarantees, diplomatic sources said. Danish Finance Minister Stephanie Lose said "some worries" still needed to be addressed but hoped a decision could be paved next week. European Commissioner Valdis Dombrovskis said solid guarantees were being put together for Belgium.\n\nHungarian Prime Minister Viktor Orban said on Facebook the move via qualified majority vote would cause irreparable damage to the bloc, and that Hungary would do all it could to "restore a lawful state of affairs."\n\nRussia's central bank said the EU plans to use its assets were illegal and reserved the right to use all available means to protect its interests. It also said it was suing Brussels-based depository Euroclear, which holds 185 billion euros of the frozen assets, in a Moscow court.\n\nThe Financial Times reported that Ukraine could join the EU by January 1, 2027 under proposals discussed in U.S.-mediated talks on ending the war, though several European officials called the date "absolutely impossible."	https://www.reuters.com/business/finance/eu-set-indefinitely-freeze-russian-assets-removing-obstacle-ukraine-loan-2025-12-12/
10	\nAuthor: Barney Ronay\n\nColumnist Barney Ronay argues that Wrexham’s latest moves strip away any lingering fairytale: public money (an £18m grant to renovate the Racecourse Ground) and a fresh minority stake sold to Apollo Sports Capital underline that the club is a modern entertainment-business project. While Apollo’s former ties via cofounder Leon Black to Jeffrey Epstein are historical and severed, the broader point is that finance, media and football are now fully entwined. \n\nRonay questions why public funds support a club now part-owned by deep-pocketed US financiers, but also notes similar precedents across English football and the tangible local economic benefits Wrexham has created. On the pitch and in the market, Wrexham’s rise has been powered by sustained speculative spend and strong commercial revenue—more “eat-what-you-kill” capitalism than miracle—yet still within profitability and sustainability rules. \n\nThe conclusion: behind the Disney-friendly narrative, Wrexham is a clear example of globalised US-style sports capital at work—schmaltz and theatre on the surface, sharp-toothed finance underneath.\n	https://www.theguardian.com/football/2025/dec/12/schmaltz-theatre-and-sharp-teeth-wrexham-reveal-the-hard-truth-about-football
13	SEOUL, Dec 13 (Reuters) - North Korean leader Kim Jong Un attended a welcoming ceremony for an army engineering unit that had returned home after carrying out duties in Russia, the North's KCNA news agency reported on Saturday.\n\nIn a speech carried by KCNA, Kim praised officers and soldiers of the 528th Regiment of Engineers of the Korean People's Army (KPA) for "heroic" conduct and "mass heroism" in fulfilling orders issued by the ruling Workers' Party of Korea during a 120-day overseas deployment.\n\nVideo footage released by North Korea showed uniformed soldiers disembarking from an aircraft, Kim hugging a soldier seated in a wheelchair, and soldiers and officials gathered to welcome the troops.\n\nKCNA said the unit had been dispatched in early August and carried out combat and engineering tasks in the Kursk region of Russia during Moscow's war with Ukraine.\n\nLast month, Russia's Defence Ministry said North Korean troops who helped Russia repel a major Ukrainian incursion into its western Kursk region are now playing an important role in clearing the area of mines.\n\nUnder a mutual defence pact between the two countries, North Korea last year sent some 14,000 soldiers to fight alongside Russia in Kursk, and more than 6,000 were killed, according to South Korean, Ukrainian and Western sources.\n\nKim said nine soldiers were killed during the mission, describing their deaths as a "heartrending loss," and announced that the regiment would be awarded the Order of Freedom and Independence. The nine fallen soldiers were awarded the title of Hero of the Democratic People's Republic of Korea, along with other state honours, KCNA said.\n\nThe welcoming ceremony was held on Friday in Pyongyang and was attended by senior military officials, ruling party leaders, families of the soldiers and large crowds, according to the report.\n\nIn his speech, Kim said the regiment had cleared dangerous areas under combat conditions and demonstrated "absolute loyalty" to the party and the state. He also praised the political indoctrination, discipline and unity among the troops, calling their performance a model for the armed forces.	https://www.reuters.com/world/asia-pacific/north-korean-leader-kim-hails-troops-returning-russia-mission-state-media-says-2025-12-12/
12	OSLO, Dec 12 (Reuters) - Iranian human rights activist and Nobel Peace Prize laureate Narges Mohammadi was arrested in a "brutal" manner in Iran and must be released immediately, the Norwegian Nobel Committee said on Friday.\n\nMohammadi has previously served multiple sentences on charges including spreading propaganda against the Islamic Republic. Late last year, she was released from Tehran's Evin prison after the suspension of her jail term to undergo medical treatment.\n\nMohammadi was awarded the Nobel Peace Prize in 2023 for her three-decade campaign for women's rights and the abolition of the death penalty in Iran.\n\n"The Norwegian Nobel Committee calls on the Iranian authorities to immediately clarify Mohammadi's whereabouts, ensure her safety and integrity, and to release her without conditions," the award body said.\n\nThe arrest comes a day after the arrival in Norway of this year's Nobel Peace Prize laureate, Venezuela's Maria Corina Machado, to collect her award. "Given the close collaboration between the regimes in Iran and Venezuela, the Norwegian Nobel Committee notes that Ms Mohammadi is arrested just as the Nobel Peace Prize has been awarded to the Venezuelan opposition leader," the committee added.	https://www.reuters.com/world/middle-east/nobel-peace-prize-committee-condemns-brutal-arrest-iranian-laureate-narges-2025-12-12/
3	House Republicans unveiled a narrow health care package on Friday that does not extend soon-to-expire enhanced Affordable Care Act subsidies — the latest sign that Congress is unlikely to avert skyrocketing insurance premiums for millions of Americans in the new year.\n\nThe GOP proposal would seek to expand association health plans, fund cost-sharing reductions for certain ACA enrollees, and impose new transparency requirements on pharmacy benefit managers. GOP leaders opted against extending the enhanced subsidies, though they expect to allow a floor vote on an amendment related to those subsidies, which are set to expire at the end of the month.\n\nSpeaker Mike Johnson said House Republicans are tackling the “real drivers” of costs. The package is slated for a vote next week, the House’s final work week of 2025, but its path remains uncertain after the Senate failed to pass duelling plans earlier this week.\n\nAbsent an extension, premiums are projected to more than double on average — around $1,000 — and roughly 2 million more people could be uninsured next year, according to KFF and the Congressional Budget Office. The proposal also seeks to codify defined contribution arrangements like HSAs but does not adopt the broader HSA expansion backed by former President Donald Trump.\n\nRepublicans also aim to restore ACA cost-sharing reduction payments that were halted during the first Trump term, a move that contributed to “silver loading” and higher premiums but increased subsidies. Refunding CSR is pitched as curbing overall federal outlays on ACA subsidies. The plan does not directly address premiums set to spike when enhanced subsidies lapse.	https://www.cnn.com/2025/12/12/politics/house-gop-health-care-plan-obamacare-subsidies
17	Congressional Republicans are pushing a health care agenda that does not extend soon-to-expire enhanced ACA subsidies, despite warnings from moderates and the prospect of sharp premium hikes. Senate votes on both GOP and Democratic proposals failed, underscoring the lack of a bipartisan path for now. Some battleground Republicans are pushing leadership — and former President Donald Trump — to back a short-term fix; others are exploring discharge petitions to force votes.\n\nIf the enhanced subsidies lapse on Dec. 31, average premiums could more than double — roughly $1,000 — and some 2 million more people could be uninsured, according to KFF and CBO. GOP leadership, including Senate Majority Leader John Thune and Speaker Mike Johnson, are focusing on cost-saving measures like HSAs and ACA cost-sharing reductions rather than extending subsidies. Internal divisions persist over whether and how long to extend the tax credits, with vulnerable House Republicans warning of political fallout next year.	https://www.cnn.com/2025/12/11/politics/health-care-vote-republicans-congress-obamacare
5	US President Donald Trump's overseas envoy, Steve Witkoff, will travel to Germany this weekend to meet Ukrainian President Volodymyr Zelensky and European leaders for the latest talks on ending the war. Witkoff, who has been leading White House mediation between Ukraine and Russia, will discuss the latest version of a proposed peace agreement in Berlin.\n\nThe administration is pushing for a deal by Christmas and has held several rounds of talks, though a breakthrough remains elusive. The Wall Street Journal reported UK Prime Minister Sir Keir Starmer, French President Emmanuel Macron and German Chancellor Friedrich Merz would take part. Ukraine recently submitted a revised 20-point peace plan to Washington.\n\nA key sticking point remains the fate of territory in eastern Ukraine. Kyiv refuses to cede land occupied by Russia; Moscow demands full control of the Donbas unless Ukraine withdraws. Zelensky has questioned a US proposal to designate vacated areas as a “special economic zone” and demilitarised buffer, asking what would deter further Russian advances.\n\nEuropean focus has turned to post-war support, security guarantees and financing. Ukraine faces an additional funding need of €135.7bn over two years. EU governments agreed to indefinitely freeze around €210bn of Russian assets, paving the way for loans to Ukraine if endorsed at an EU summit next week. Russia condemned the move as theft, and its central bank said it would sue Euroclear. Reports also suggest Ukraine’s rapid EU accession is being discussed, potentially as soon as January 2027, though the timeline remains uncertain.	https://www.bbc.com/news/articles/c0l9954yr9ko
\.


--
-- Data for Name: article_medias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.article_medias (id, article_id, url, size, type, reference, "position") FROM stdin;
1	1	https://static01.nyt.com/images/2025/12/12/multimedia/12int-venezuela-cuba-oil-qcpz/12int-venezuela-cuba-oil-qcpz-superJumbo.jpg?quality=75&auto=webp	1	image	https://www.nytimes.com/2025/12/12/world/americas/venezuela-cuba-oil-tanker.html?smid=url-share	1
2	1	https://static01.nyt.com/images/2025/12/12/multimedia/12int-venezuela-cuba-oil-zmjb/12int-venezuela-cuba-oil-zmjb-superJumbo.jpg?quality=75&auto=webp	1	image	https://www.nytimes.com/2025/12/12/world/americas/venezuela-cuba-oil-tanker.html?smid=url-share	2
3	1	https://static01.nyt.com/images/2025/12/12/world/12int-venezuela-cuba-oil/12int-venezuela-cuba-oil-superJumbo.jpg?quality=75&auto=webp	1	image	https://www.nytimes.com/2025/12/12/world/americas/venezuela-cuba-oil-tanker.html?smid=url-share	2
4	1	https://static01.nyt.com/images/2020/10/08/world/12int-venezuela-cuba-oil-4/merlin_177548454_93a8c204-b41b-4856-8222-9b571be0004e-superJumbo.jpg?quality=75&auto=webp	1	image	https://www.nytimes.com/2025/12/12/world/americas/venezuela-cuba-oil-tanker.html?smid=url-share	2
5	2	https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2250380996-20251212195701422.jpg?c=original&q=w_860,c_fill/f_avif	\N	image	https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2250380996-20251212195701422.jpg?c=original&q=w_860,c_fill/f_avif	1
6	2	https://media.cnn.com/api/v1/images/stellar/prod/img-0762-20251211212617243.jpg?c=original&q=w_860,c_fill/f_webp	\N	image	cnn news	2
7	2	https://media.cnn.com/api/v1/images/stellar/prod/ap25305051189306.jpg?c=original&q=w_860,c_fill/f_webp	\N	image	cnn news	3
8	3	https://media.cnn.com/api/v1/images/stellar/prod/ap25344719252699.jpg?c=original&q=w_860,c_fill/f_avif	\N	image	https://www.cnn.com/2025/12/12/politics/house-gop-health-care-plan-obamacare-subsidies	1
9	4	https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2250290067.jpg?c=original&q=w_860,c_fill/f_webp	\N	image	https://www.cnn.com/2025/12/11/politics/health-care-vote-republicans-congress-obamacare?iid=cnn_buildContentRecirc_end_recirc&recs_exp=up-next-article-end&tenant_id=related.en	1
10	4	https://media.cnn.com/api/v1/images/stellar/prod/2025-12-02t204543z-1198010537-rc2i8ianw6bk-rtrmadp-3-usa-congress.jpg?c=original&q=w_860,c_fill/f_webp	\N	image	https://www.cnn.com/2025/12/11/politics/health-care-vote-republicans-congress-obamacare?iid=cnn_buildContentRecirc_end_recirc&recs_exp=up-next-article-end&tenant_id=related.en	2
11	5	https://ichef.bbci.co.uk/news/1536/cpsprodpb/2056/live/0d936380-d7de-11f0-a8dc-93c15fe68710.png.webp	\N	image	https://www.bbc.com/news/articles/c0l9954yr9ko	2
12	5	https://ichef.bbci.co.uk/news/1536/cpsprodpb/fc88/live/1738fb80-d7dd-11f0-a7d3-d3e62a2a1617.jpg.webp	\N	image	https://www.bbc.com/news/articles/c0l9954yr9ko	1
13	6	https://ichef.bbci.co.uk/news/1536/cpsprodpb/bfc2/live/e4293590-d78a-11f0-b0ee-a9375724f730.jpg.webp	\N	image	https://www.bbc.com/news/articles/cd0kkyx3vvxo	1
14	7	https://i.guim.co.uk/img/media/c767910be880292e9894fd26a55d50d5947b2fcf/0_0_4000_2668/master/4000.jpg?width=620&dpr=2&s=none&crop=none	\N	image	https://www.theguardian.com/us-news/2025/dec/12/house-republicans-health-insurance-plan	1
15	8	https://i.guim.co.uk/img/media/2fce6f92f510752bf16ada034e0eb65174547ee8/0_0_3000_2001/master/3000.jpg?width=620&dpr=2&s=none&crop=none	\N	image	https://www.theguardian.com/us-news/2025/dec/12/new-york-street-vendors-ice-national-guard	2
16	8	https://i.guim.co.uk/img/media/e765e0e400c8feb9db3642789879e76c051f8b7d/0_0_7624_5085/master/7624.jpg?width=620&dpr=2&s=none&crop=none	\N	image	https://www.theguardian.com/us-news/2025/dec/12/new-york-street-vendors-ice-national-guard	1
17	8	https://i.guim.co.uk/img/media/72b009b8fc9049d2ff2e483d9ab9cd0d5b729417/0_0_4032_3024/master/4032.jpg?width=620&dpr=2&s=none&crop=none	\N	image	https://www.theguardian.com/us-news/2025/dec/12/new-york-street-vendors-ice-national-guard	3
18	9	https://i.guim.co.uk/img/media/f3d389304ecd3aee59e612d822be4307669e83fc/0_0_4187_2791/master/4187.jpg?width=620&dpr=2&s=none&crop=none	\N	image	https://www.theguardian.com/sport/2025/dec/12/caitlin-clark-wnba-cba-team-usa-debut-lawson	1
19	9	https://i.guim.co.uk/img/media/c05f1446cfd462f1eb5633ebc03f82d31cc6f48d/0_0_5000_3334/master/5000.jpg?width=620&dpr=2&s=none&crop=none	\N	image	https://www.theguardian.com/sport/2025/dec/12/caitlin-clark-wnba-cba-team-usa-debut-lawson	2
20	10	https://i.guim.co.uk/img/media/0030a7a997fd393e963a84bc9f35a93394e5e723/0_0_2700_1518/master/2700.jpg?width=620&dpr=2&s=none&crop=none	\N	image	https://www.theguardian.com/football/2025/dec/12/schmaltz-theatre-and-sharp-teeth-wrexham-reveal-the-hard-truth-about-football	1
21	10	https://i.guim.co.uk/img/media/3171f4536737915e32a18979cb56637f23d055b0/0_0_4816_3211/master/4816.jpg?width=620&dpr=2&s=none&crop=none	\N	image	https://www.theguardian.com/football/2025/dec/12/schmaltz-theatre-and-sharp-teeth-wrexham-reveal-the-hard-truth-about-football	2
22	11	https://www.reuters.com/resizer/v2/M6TA5EEPIZJQHIZA2YATILTQJI.jpg?auth=ca6f8439e7ef0f712042ce38a86fbad3fd10efa15458bdccfbc5739a20fe506a&width=1920&quality=80	\N	image	https://www.reuters.com/business/finance/eu-set-indefinitely-freeze-russian-assets-removing-obstacle-ukraine-loan-2025-12-12/	2
23	11	https://www.reuters.com/resizer/v2/CSVXIKSLTRJO5OUGECPRDS52SE.jpg?auth=8587f0f5232a01c203e43a455cd17c96bab16ef7978e17409e09b92a3b6fa750&width=1920&quality=80	\N	image	https://www.reuters.com/business/finance/eu-set-indefinitely-freeze-russian-assets-removing-obstacle-ukraine-loan-2025-12-12/	1
24	12	https://www.reuters.com/resizer/v2/2ZJ2JNG5XBKZLIV7V2ZZM5ZSL4.jpg?auth=71da4557ad6d429668585b44548c07eac6619aaaba16616b0e2600a5aa62751c&width=1200&quality=80	\N	image	https://www.reuters.com/world/middle-east/nobel-peace-prize-committee-condemns-brutal-arrest-iranian-laureate-narges-2025-12-12/	1
25	13	https://www.reuters.com/resizer/v2/FL4S2EUFG5J67DVWH7TWCZHB6E.jpg?width=1200&quality=80	\N	cover	\N	1
26	11	https://www.reuters.com/resizer/v2/CSVXIKSLTRJO5OUGECPRDS52SE.jpg?width=1920&quality=80	\N	cover	\N	1
27	12	https://www.reuters.com/resizer/v2/2ZJ2JNG5XBKZLIV7V2ZZM5ZSL4.jpg?width=1200&quality=80	\N	cover	\N	1
28	3	https://media.cnn.com/api/v1/images/stellar/prod/ap25344719252699.jpg?c=original&q=w_860,c_fill/f_avif	\N	cover	\N	1
29	17	https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2250290067.jpg?c=original&q=w_860,c_fill/f_webp	\N	cover	\N	1
30	5	https://ichef.bbci.co.uk/news/1536/cpsprodpb/fc88/live/1738fb80-d7dd-11f0-a7d3-d3e62a2a1617.jpg.webp	\N	cover	\N	1
\.


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.articles (id, source_id, title, url, is_deleted, last_update, create_time, delete_time, author) FROM stdin;
1	1	Behind the Seized Venezuelan Tanker, Cuba’s Secret Lifeline	https://www.nytimes.com/2025/12/12/world/americas/venezuela-cuba-oil-tanker.html?smid=url-share	f	2025-12-13 03:41:52.168874	2025-12-13 03:41:52.168874	\N	Anatoly KurmanaevNicholas Nehamas and Farnaz Fassihi
2	3	24 hours that showed the limits of Trump’s power	https://www.cnn.com/2025/12/12/politics/power-limitations-trump-analysis	f	2025-12-13 05:39:37.751388	2025-12-13 05:39:37.751388	\N	\N
4	3	A divided GOP forges ahead on health care message — without plan to address spiking premiums	https://www.cnn.com/2025/12/11/politics/health-care-vote-republicans-congress-obamacare?iid=cnn_buildContentRecirc_end_recirc&recs_exp=up-next-article-end&tenant_id=related.en	f	2025-12-13 05:44:30.590869	2025-12-13 05:44:30.590869	\N	\N
6	2	Thailand-Cambodia fighting continues after Trump says countries agree to ceasefire	https://www.bbc.com/news/articles/cd0kkyx3vvxo	f	2025-12-13 05:47:16.550442	2025-12-13 05:47:16.550442	\N	\N
7	5	House Republicans propose healthcare plan with no extension of tax credits	https://www.theguardian.com/us-news/2025/dec/12/house-republicans-health-insurance-plan	f	2025-12-13 05:48:34.767675	2025-12-13 05:48:34.767675	\N	\N
8	5	‘There’s power in numbers’: New Yorkers are banding together to protect street vendors from ICE	https://www.theguardian.com/us-news/2025/dec/12/new-york-street-vendors-ice-national-guard	f	2025-12-13 05:51:10.477848	2025-12-13 05:51:10.477848	\N	\N
9	5	Caitlin Clark says CBA negotiations are ‘biggest moment in the history of the WNBA’	https://www.theguardian.com/sport/2025/dec/12/caitlin-clark-wnba-cba-team-usa-debut-lawson	f	2025-12-13 05:51:23.027479	2025-12-13 05:51:23.027479	\N	\N
10	5	Schmaltz, theatre and sharp teeth: Wrexham reveal the hard truth about football	https://www.theguardian.com/football/2025/dec/12/schmaltz-theatre-and-sharp-teeth-wrexham-reveal-the-hard-truth-about-football	f	2025-12-13 05:55:51.464317	2025-12-13 05:53:47.461836	\N	\N
13	4	North Korean leader Kim hails troops returning from Russia mission, state media says	https://www.reuters.com/world/asia-pacific/north-korean-leader-kim-hails-troops-returning-russia-mission-state-media-says-2025-12-12/	f	2025-12-13 00:00:00	2025-12-13 06:03:03.908008	\N	Reuters (Heekyong Yang; Ju-min Park; editors as credited)
11	4	EU agrees to indefinitely freeze Russian assets, removing obstacle to Ukraine loan	https://www.reuters.com/business/finance/eu-set-indefinitely-freeze-russian-assets-removing-obstacle-ukraine-loan-2025-12-12/	f	2025-12-12 00:00:00	2025-12-13 05:57:54.089934	\N	Jan Strupczewski
12	4	Nobel Peace Prize committee condemns "brutal" arrest of Iranian laureate Narges Mohammadi	https://www.reuters.com/world/middle-east/nobel-peace-prize-committee-condemns-brutal-arrest-iranian-laureate-narges-2025-12-12/	f	2025-12-12 00:00:00	2025-12-13 05:59:20.774086	\N	Reuters (Gwladys Fouché; editors as credited)
3	3	House GOP unveils narrow health care package with key deadline looming	https://www.cnn.com/2025/12/12/politics/house-gop-health-care-plan-obamacare-subsidies	f	2025-12-12 00:00:00	2025-12-13 05:41:45.021887	\N	Sarah Ferris; Adam Cancryn; Tami Luhby
17	3	A divided GOP forges ahead on health care message — without plan to address spiking premiums	https://www.cnn.com/2025/12/11/politics/health-care-vote-republicans-congress-obamacare	f	2025-12-11 00:00:00	2025-12-13 06:03:03.908008	\N	Sarah Ferris
5	2	Witkoff to meet Zelensky for latest Ukraine war talks	https://www.bbc.com/news/articles/c0l9954yr9ko	f	2025-12-12 00:00:00	2025-12-13 05:45:27.525549	\N	BBC News (byline per page)
\.


--
-- Data for Name: bookmark; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookmark (user_id, article_id, create_at, is_deleted) FROM stdin;
\.


--
-- Data for Name: crawl_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crawl_job (id, source_id, start_time, end_time, status, message) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: newsapp
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	<< Flyway Baseline >>	BASELINE	<< Flyway Baseline >>	\N	newsapp	2025-12-08 22:47:34.137446	0	t
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.follows (user_id, topic_id, create_time, notification_level) FROM stdin;
11	6	2025-12-13 03:06:30.999979	site
\.


--
-- Data for Name: history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.history (user_id, article_id, first_seen, last_seen) FROM stdin;
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sources (id, name, url, api, is_deleted, last_update, create_time, delete_time) FROM stdin;
1	New York Times	https://www.nytimes.com	https://api.nytimes.com/svc/news/v3/content/all/all.json	f	2025-12-13 00:51:09.050827	2025-12-13 00:51:09.050827	\N
6	TechCrunch	https://techcrunch.com	https://techcrunch.com/wp-json/wp/v2/posts	f	2025-12-13 00:51:09.050827	2025-12-13 00:51:09.050827	\N
7	Bloomberg	https://www.bloomberg.com	https://www.bloomberg.com/feed/podcast.xml	f	2025-12-13 00:51:09.050827	2025-12-13 00:51:09.050827	\N
8	AP News	https://apnews.com	https://api.apnews.com/api/v3/articles	f	2025-12-13 00:51:09.050827	2025-12-13 00:51:09.050827	\N
9	test1	test1	test1	t	2025-12-13 01:03:14.423977	2025-12-13 01:00:02.690383	2025-12-13 01:03:14.420569
3	CNN Politics	https://www.cnn.com	https://www.cnn.com	f	2025-12-13 00:51:09.050827	2025-12-13 00:51:09.050827	\N
2	BBC News	https://www.bbc.com	https://www.bbc.com	f	2025-12-13 00:51:09.050827	2025-12-13 00:51:09.050827	\N
5	The Guardian	https://www.theguardian.com	https://www.theguardian.com	f	2025-12-13 00:51:09.050827	2025-12-13 00:51:09.050827	\N
4	Reuters	https://www.reuters.com	https://www.reuters.com	f	2025-12-13 00:51:09.050827	2025-12-13 00:51:09.050827	\N
\.


--
-- Data for Name: topic_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topic_articles (topic_id, article_id, assigned_at) FROM stdin;
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics (id, keyword, is_deleted) FROM stdin;
1	Breaking News	f
2	World News	f
3	US Politics	f
4	China News	f
5	Europe	f
7	Business	f
8	Markets	f
9	Technology	f
10	Science	f
11	Opinion	f
12	Lifestyle	f
13	Culture	f
14	Music	f
15	Art	f
16	Food	f
17	Weather	f
18	Local News	f
6	Middle East	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, created_at, role, is_deleted) FROM stdin;
12	editor1	editor11@email.com	$2a$10$gaDsc5eNynlsW.R1dC4ww.MqUa73O1Timpt1KXJKSEE4E6fYe0JO6	2025-12-10 02:33:43.270854	editor	f
13	editor2	editor2@email.com	$2a$10$hAZ0p96qepq.ViDzmryowulIvRkWsl3.x4a7BSTBYOuKoZUnTF.5y	2025-12-10 02:33:49.160294	editor	f
14	editor3	editor3@email.com	$2a$10$hcrdeelUeSyRstCE7viSHeAq7Hxe0SdIWor6okgRXtzjHZnD7FdL2	2025-12-10 02:33:56.119821	editor	f
10	admin	admin@email.com	$2a$10$KhHFV.IZCergbyPrKszQXOgtAUr2nrtqgCEEina.A50wdJUtHSX12	2025-12-10 02:33:16.779097	admin	f
1	teswevt	email@email.com	123456	2025-12-09 05:57:03.030808	admin	t
11	admin_1	admin_a@email.com	$2a$10$S9EY6sVwg1RM150rPTuMGepa7bCHiUzFdJ3SL5Qqfct/XrKLpopDW	2025-12-10 02:33:27.3509	admin	f
2	username1	email1@email.com	$2a$10$NpmSCpoPPYs/bVJTdc6niukHMXLsYCigqRL.XD6Bd.FZCQt3wu7si	2025-12-10 00:37:38.039606	user	t
15	testupdate666	test@update.com	123	2025-12-10 03:24:19.625862	editor	f
\.


--
-- Name: article_medias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.article_medias_id_seq', 30, true);


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.articles_id_seq', 18, true);


--
-- Name: crawl_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.crawl_job_id_seq', 1, false);


--
-- Name: sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sources_id_seq', 13, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topics_id_seq', 19, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 15, true);


--
-- Name: article_contents article_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article_contents
    ADD CONSTRAINT article_contents_pkey PRIMARY KEY (article_id);


--
-- Name: article_medias article_medias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article_medias
    ADD CONSTRAINT article_medias_pkey PRIMARY KEY (id);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: bookmark bookmark_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookmark
    ADD CONSTRAINT bookmark_pkey PRIMARY KEY (user_id, article_id);


--
-- Name: crawl_job crawl_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crawl_job
    ADD CONSTRAINT crawl_job_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: newsapp
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (user_id, topic_id);


--
-- Name: history history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (user_id, article_id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: topic_articles topic_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topic_articles
    ADD CONSTRAINT topic_articles_pkey PRIMARY KEY (topic_id, article_id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: users uq_users_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uq_users_email UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: newsapp
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_articles_source; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_articles_source ON public.articles USING btree (source_id);


--
-- Name: idx_follows_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_follows_user ON public.follows USING btree (user_id);


--
-- Name: idx_history_user_last; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_history_user_last ON public.history USING btree (user_id, last_seen DESC);


--
-- Name: idx_media_article; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_media_article ON public.article_medias USING btree (article_id);


--
-- Name: idx_topic_articles_article; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_topic_articles_article ON public.topic_articles USING btree (article_id);


--
-- Name: uq_articles_url_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_articles_url_active ON public.articles USING btree (url) WHERE (is_deleted = false);


--
-- Name: uq_sources_url_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_sources_url_active ON public.sources USING btree (url) WHERE (is_deleted = false);


--
-- Name: uq_users_username_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_users_username_active ON public.users USING btree (username) WHERE (is_deleted = false);


--
-- Name: article_contents article_contents_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article_contents
    ADD CONSTRAINT article_contents_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: article_medias article_medias_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article_medias
    ADD CONSTRAINT article_medias_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: articles articles_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: bookmark bookmark_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookmark
    ADD CONSTRAINT bookmark_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: bookmark bookmark_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookmark
    ADD CONSTRAINT bookmark_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: crawl_job crawl_job_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crawl_job
    ADD CONSTRAINT crawl_job_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(id) ON DELETE CASCADE;


--
-- Name: follows follows_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE CASCADE;


--
-- Name: follows follows_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: history history_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: history history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: topic_articles topic_articles_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topic_articles
    ADD CONSTRAINT topic_articles_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: topic_articles topic_articles_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topic_articles
    ADD CONSTRAINT topic_articles_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE CASCADE;


--
-- Name: TABLE article_contents; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.article_contents TO newsapp;


--
-- Name: TABLE article_medias; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.article_medias TO newsapp;


--
-- Name: SEQUENCE article_medias_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.article_medias_id_seq TO newsapp;


--
-- Name: TABLE articles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.articles TO newsapp;


--
-- Name: SEQUENCE articles_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.articles_id_seq TO newsapp;


--
-- Name: TABLE bookmark; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.bookmark TO newsapp;


--
-- Name: TABLE crawl_job; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.crawl_job TO newsapp;


--
-- Name: SEQUENCE crawl_job_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.crawl_job_id_seq TO newsapp;


--
-- Name: TABLE follows; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.follows TO newsapp;


--
-- Name: TABLE history; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.history TO newsapp;


--
-- Name: TABLE sources; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.sources TO newsapp;


--
-- Name: SEQUENCE sources_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.sources_id_seq TO newsapp;


--
-- Name: TABLE topic_articles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.topic_articles TO newsapp;


--
-- Name: TABLE topics; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.topics TO newsapp;


--
-- Name: SEQUENCE topics_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.topics_id_seq TO newsapp;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.users TO newsapp;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.users_id_seq TO newsapp;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: newsapp
--

ALTER DEFAULT PRIVILEGES FOR ROLE newsapp IN SCHEMA public GRANT ALL ON SEQUENCES TO newsapp;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO newsapp;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: newsapp
--

ALTER DEFAULT PRIVILEGES FOR ROLE newsapp IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO newsapp;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO newsapp;


--
-- PostgreSQL database dump complete
--

\unrestrict FXlnJAsfOIpLWRraqjXvZ3hsXI1E6O4KCxgZmSGCedhDxaB6YRBIh4bWAQbiAVI

