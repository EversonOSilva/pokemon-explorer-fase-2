
import React, { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  Image,
  FlatList,
  ScrollView,
  StyleSheet,
  StatusBar,
  TouchableOpacity,
  Alert,
} from 'react-native';

const COLORS = {
  background: '#F5F7FC',
  navy: '#19365B',
  yellow: '#FFC928',
  red: '#E84B4B',
  white: '#FFFFFF',
  gray: '#E9EAEC',
  border: '#E3E6ED',
  text: '#24344D',
  secondary: '#778397',
};

const POKEMON = [
  { id: 1, name: 'Bulbasaur', types: ['Grass', 'Poison'] },
  { id: 4, name: 'Charmander', types: ['Fire'] },
  { id: 7, name: 'Squirtle', types: ['Water'] },
  { id: 25, name: 'Pikachu', types: ['Electric'] },
  { id: 39, name: 'Jigglypuff', types: ['Fairy', 'Normal'] },
  { id: 133, name: 'Eevee', types: ['Normal'] },
  { id: 6, name: 'Charizard', types: ['Fire', 'Flying'] },
  { id: 150, name: 'Mewtwo', types: ['Psychic'] },
];

const FILTERS = [
  'Todos',
  'Grass',
  'Fire',
  'Water',
  'Electric',
  'Normal',
  'Fairy',
  'Poison',
  'Psychic',
];

function PokemonCard({ pokemon }) {
  const imageUrl =
    `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png`;

  return (
    <View style={styles.card}>
      <View style={styles.imageContainer}>
        <Text style={styles.number}>
          #{String(pokemon.id).padStart(3, '0')}
        </Text>

        <Image
          source={{ uri: imageUrl }}
          style={styles.pokemonImage}
          resizeMode="contain"
        />
      </View>

      <Text style={styles.pokemonName}>{pokemon.name}</Text>

      <Text style={styles.pokemonNumber}>
        Nº {String(pokemon.id).padStart(3, '0')}
      </Text>

      <View style={styles.typesContainer}>
        {pokemon.types.map((type) => (
          <View key={type} style={styles.typeBadge}>
            <Text style={styles.typeText}>{type}</Text>
          </View>
        ))}
      </View>

      <TouchableOpacity
        style={styles.movesButton}
        onPress={() =>
          Alert.alert(
            pokemon.name,
            `Você selecionou ${pokemon.name} para consultar seus movimentos.`
          )
        }
      >
        <Text style={styles.movesButtonText}>Ver movimentos  ›</Text>
      </TouchableOpacity>
    </View>
  );
}

export default function App() {
  const [search, setSearch] = useState('');
  const [selectedFilter, setSelectedFilter] = useState('Todos');
  const [showFilters, setShowFilters] = useState(false);
  const [activeTab, setActiveTab] = useState('Explorar');

  const filteredPokemon = POKEMON.filter((pokemon) => {
    const matchesSearch =
      pokemon.name.toLowerCase().includes(search.toLowerCase()) ||
      String(pokemon.id).includes(search);

    const matchesFilter =
      selectedFilter === 'Todos' ||
      pokemon.types.includes(selectedFilter);

    return matchesSearch && matchesFilter;
  });

  function changeTab(tab) {
    setActiveTab(tab);

    if (tab !== 'Explorar') {
      Alert.alert(
        tab,
        'Esta é uma tela adicional demonstrativa da versão React Native.'
      );
      setActiveTab('Explorar');
    }
  }

  return (
    <View style={styles.container}>
      <StatusBar
        backgroundColor={COLORS.background}
        barStyle="dark-content"
      />

      {/* CABEÇALHO */}
      <View style={styles.header}>
        <View style={styles.brandContainer}>
          <View style={styles.logo}>
            <Text style={styles.logoText}>●</Text>
          </View>

          <View>
            <Text style={styles.brandName}>POKÉMON</Text>
            <Text style={styles.brandSubtitle}>EXPLORER</Text>
          </View>
        </View>

        <View style={styles.regionBadge}>
          <Text style={styles.regionText}>BR</Text>
        </View>
      </View>

      {/* TÍTULO */}
      <View style={styles.intro}>
        <Text style={styles.pageTitle}>Pokédex</Text>
        <Text style={styles.pageSubtitle}>
          Explore o mundo Pokémon
        </Text>
      </View>

      {/* PESQUISA */}
      <View style={styles.searchRow}>
        <View style={styles.searchContainer}>
          <Text style={styles.searchIcon}>⌕</Text>

          <TextInput
            style={styles.searchInput}
            placeholder="Buscar Pokémon..."
            placeholderTextColor={COLORS.secondary}
            value={search}
            onChangeText={setSearch}
          />
        </View>

        <TouchableOpacity
          style={styles.filterIconButton}
          onPress={() => setShowFilters(!showFilters)}
        >
          <Text style={styles.filterIcon}>☷</Text>
        </TouchableOpacity>
      </View>

      {/* FILTROS */}
      {showFilters && (
        <View style={styles.filtersArea}>
          <Text style={styles.filterTitle}>Filtrar por tipo</Text>

          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
          >
            {FILTERS.map((filter) => {
              const selected = selectedFilter === filter;

              return (
                <TouchableOpacity
                  key={filter}
                  style={[
                    styles.filterButton,
                    selected && styles.filterSelected,
                  ]}
                  onPress={() => setSelectedFilter(filter)}
                >
                  <Text
                    style={[
                      styles.filterText,
                      selected && styles.filterTextSelected,
                    ]}
                  >
                    {filter}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </ScrollView>
        </View>
      )}

      {/* LISTAGEM */}
      <View style={styles.listHeader}>
        <Text style={styles.listTitle}>Pokémon encontrados</Text>
        <Text style={styles.counter}>
          {filteredPokemon.length} resultados
        </Text>
      </View>

      <FlatList
        data={filteredPokemon}
        keyExtractor={(item) => String(item.id)}
        numColumns={2}
        columnWrapperStyle={styles.cardRow}
        contentContainerStyle={styles.listContent}
        showsVerticalScrollIndicator={false}
        renderItem={({ item }) => (
          <PokemonCard pokemon={item} />
        )}
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Text style={styles.emptyTitle}>
              Nenhum Pokémon encontrado
            </Text>
            <Text style={styles.emptyText}>
              Tente alterar sua pesquisa ou filtro.
            </Text>
          </View>
        }
      />

      {/* MENU INFERIOR */}
      <View style={styles.bottomNavigation}>
        <TouchableOpacity
          style={styles.navItem}
          onPress={() => changeTab('Explorar')}
        >
          <Text style={[
            styles.navIcon,
            activeTab === 'Explorar' && styles.navActive,
          ]}>⌕</Text>
          <Text style={[
            styles.navLabel,
            activeTab === 'Explorar' && styles.navActive,
          ]}>Explorar</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.navItem}
          onPress={() => changeTab('Favoritos')}
        >
          <Text style={styles.navIcon}>♡</Text>
          <Text style={styles.navLabel}>Favoritos</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.navItem}
          onPress={() => changeTab('Perfil')}
        >
          <Text style={styles.navIcon}>♙</Text>
          <Text style={styles.navLabel}>Perfil</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
    paddingTop: 8,
  },

  header: {
    height: 65,
    paddingHorizontal: 20,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    borderBottomWidth: 1,
    borderBottomColor: COLORS.border,
  },

  brandContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
  },

  logo: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: COLORS.red,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 3,
    borderColor: COLORS.white,
  },

  logoText: {
    color: COLORS.white,
    fontSize: 17,
  },

  brandName: {
    color: COLORS.navy,
    fontWeight: '900',
    fontSize: 13,
    letterSpacing: 1.2,
  },

  brandSubtitle: {
    color: COLORS.secondary,
    fontWeight: 'bold',
    fontSize: 9,
    letterSpacing: 2.5,
  },

  regionBadge: {
    width: 37,
    height: 37,
    borderRadius: 20,
    backgroundColor: COLORS.navy,
    alignItems: 'center',
    justifyContent: 'center',
  },

  regionText: {
    color: COLORS.white,
    fontWeight: 'bold',
    fontSize: 12,
  },

  intro: {
    paddingHorizontal: 20,
    paddingTop: 20,
    paddingBottom: 16,
  },

  pageTitle: {
    fontSize: 27,
    fontWeight: '900',
    color: COLORS.navy,
  },

  pageSubtitle: {
    fontSize: 13,
    color: COLORS.secondary,
    marginTop: 4,
  },

  searchRow: {
    flexDirection: 'row',
    paddingHorizontal: 20,
    gap: 10,
    marginBottom: 20,
  },

  searchContainer: {
    flex: 1,
    height: 45,
    backgroundColor: COLORS.white,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: COLORS.border,
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 12,
  },

  searchIcon: {
    fontSize: 25,
    color: COLORS.secondary,
    marginRight: 8,
  },

  searchInput: {
    flex: 1,
    fontSize: 13,
    color: COLORS.text,
  },

  filterIconButton: {
    width: 45,
    height: 45,
    borderRadius: 12,
    backgroundColor: COLORS.navy,
    justifyContent: 'center',
    alignItems: 'center',
  },

  filterIcon: {
    color: COLORS.white,
    fontSize: 23,
  },

  filtersArea: {
    paddingHorizontal: 20,
    marginBottom: 16,
  },

  filterTitle: {
    color: COLORS.navy,
    fontWeight: 'bold',
    fontSize: 13,
    marginBottom: 10,
  },

  filterButton: {
    paddingHorizontal: 13,
    paddingVertical: 8,
    borderRadius: 18,
    backgroundColor: COLORS.white,
    borderWidth: 1,
    borderColor: COLORS.border,
    marginRight: 7,
  },

  filterSelected: {
    backgroundColor: COLORS.navy,
    borderColor: COLORS.navy,
  },

  filterText: {
    fontSize: 11,
    color: COLORS.navy,
    fontWeight: '600',
  },

  filterTextSelected: {
    color: COLORS.white,
  },

  listHeader: {
    paddingHorizontal: 20,
    marginBottom: 13,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },

  listTitle: {
    color: COLORS.navy,
    fontSize: 15,
    fontWeight: 'bold',
  },

  counter: {
    color: COLORS.secondary,
    fontSize: 11,
  },

  listContent: {
    paddingHorizontal: 14,
    paddingBottom: 15,
  },

  cardRow: {
    justifyContent: 'space-between',
  },

  card: {
    width: '48%',
    backgroundColor: COLORS.white,
    borderRadius: 19,
    padding: 10,
    marginBottom: 14,
    borderWidth: 1,
    borderColor: COLORS.border,
    elevation: 2,
  },

  imageContainer: {
    height: 120,
    borderRadius: 13,
    backgroundColor: COLORS.gray,
    justifyContent: 'center',
    alignItems: 'center',
    position: 'relative',
  },

  number: {
    position: 'absolute',
    top: 8,
    right: 9,
    color: COLORS.secondary,
    fontSize: 10,
    fontWeight: 'bold',
  },

  pokemonImage: {
    width: '90%',
    height: '90%',
  },

  pokemonName: {
    fontSize: 16,
    color: COLORS.navy,
    fontWeight: 'bold',
    marginTop: 10,
  },

  pokemonNumber: {
    fontSize: 10,
    color: COLORS.secondary,
    marginTop: 3,
    marginBottom: 8,
  },

  typesContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 5,
    marginBottom: 12,
  },

  typeBadge: {
    backgroundColor: COLORS.yellow,
    paddingHorizontal: 9,
    paddingVertical: 5,
    borderRadius: 8,
  },

  typeText: {
    color: COLORS.navy,
    fontWeight: 'bold',
    fontSize: 9,
  },

  movesButton: {
    backgroundColor: COLORS.navy,
    borderRadius: 9,
    paddingVertical: 9,
    alignItems: 'center',
  },

  movesButtonText: {
    color: COLORS.white,
    fontSize: 10,
    fontWeight: 'bold',
  },

  emptyContainer: {
    padding: 30,
    alignItems: 'center',
  },

  emptyTitle: {
    fontSize: 15,
    fontWeight: 'bold',
    color: COLORS.navy,
  },

  emptyText: {
    fontSize: 12,
    color: COLORS.secondary,
    marginTop: 7,
  },

  bottomNavigation: {
    height: 65,
    backgroundColor: COLORS.white,
    borderTopWidth: 1,
    borderTopColor: COLORS.border,
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
  },

  navItem: {
    alignItems: 'center',
    justifyContent: 'center',
    flex: 1,
  },

  navIcon: {
    fontSize: 21,
    color: COLORS.secondary,
  },

  navLabel: {
    fontSize: 10,
    color: COLORS.secondary,
    marginTop: 3,
  },

  navActive: {
    color: COLORS.navy,
    fontWeight: 'bold',
  },
});
